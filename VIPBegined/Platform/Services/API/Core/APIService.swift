//
//  APIService.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift
import RxAlamofire

protocol APIServiceType {

    func request<T: Mappable>(_ input: APIBaseInput) -> Observable<T>
    func upload<T: Mappable>(_ input: APIUploadBaseInput) -> Observable<T>

}

typealias JSONDictionary = [String: Any]
typealias JSONArray = [JSONDictionary]

final class APIService: APIServiceType {

    static let shared = APIService()
}

extension APIService {

    func request<T: Mappable>(_ input: APIBaseInput) -> Observable<T> {
        return request(input)
            .map { json -> T in
                if let output = T(JSON: json) {
                    return output
                }
                throw APIResponseError.invalidResponseData
        }
    }

    func upload<T: Mappable>(_ input: APIUploadBaseInput) -> Observable<T> {
        return upload(input, data: input.uploadData)
            .map { json -> T in
                if let output = T(JSON: json) {
                    return output
                }
                throw APIResponseError.invalidResponseData
        }
    }
}

// MARK: - Implemement methods
extension APIService {
    fileprivate func request(_ input: APIBaseInput) -> Observable<JSONDictionary> {
        let urlRequest = preprocessInput(input)
            .do(onNext: { input in
                print("====================Request====================")
                print("URL: \(input.urlString)\nMethod: \(input.method.rawValue)")
                print("Params: \(input.parameters ?? [:])\nHeaders: \(input.headers)")
                print("====================Request====================")
            })
            .flatMapLatest { input in
                Alamofire.Session.default.rx
                    .request(input.method,
                             input.urlString,
                             parameters: input.parameters,
                             encoding: input.encoding,
                             headers: input.headers)
        }
        .flatMapLatest { dataRequest -> Observable<DataResponse<Any, AFError>> in
            return dataRequest.rx.responseJSON()
        }
        .map { (dataResponse) -> JSONDictionary in
            return try self.processResponse(dataResponse, url: input.url)
        }
        .catch({ error -> Observable<JSONDictionary> in
            if let error = error as? APIResponseError {
                return self.refreshIDTokenIfExpired(error)
                .flatMapLatest({ [weak self] isRefreshed -> Observable<JSONDictionary> in
                    guard let this = self else { return Observable.empty() }
                    if isRefreshed {
                        return this.request(input)
                    } else {
                        return Observable.error(error)
                    }
                })
            }
            throw error
        })

        return urlRequest
    }

    fileprivate func upload(_ input: APIUploadBaseInput, data: [APIUploadData]) -> Observable<JSONDictionary> {
        return preprocessUploadInput(input)
            .do(onNext: { input in
                print("====================Request====================")
                print("URL: \(input.urlString)\nMethod: \(input.method.rawValue)")
                print("Params: \(input.parameters ?? [:])\nHeaders: \(input.headers)")
                print("====================Request====================")
            })
            .flatMapLatest { input -> Observable<UploadRequest> in
                return Alamofire.Session.default.rx
                        .upload(multipartFormData: { multipartFormData in
                        if let params = input.parameters {
                            for (key, value) in params {
                                if let data = String(describing: value).data(using:.utf8) {
                                    multipartFormData.append(data, withName: key)
                                }
                            }
                        }
                        data.forEach({
                            if let uploadData = $0.data {
                                multipartFormData.append(uploadData,
                                                         withName: $0.name,
                                                         fileName: $0.fileName,
                                                         mimeType: $0.mimeType)
                            }
                        })
                    }, to: input.urlString, method: input.method, headers: input.headers)
            }
            .flatMapLatest { dataRequest -> Observable<DataResponse<Any, AFError>> in
                return dataRequest.rx.responseJSON()
            }
            .map { (dataResponse) -> JSONDictionary in
                return try self.processResponse(dataResponse, url: input.url)
            }
            .catch({ error -> Observable<JSONDictionary> in
                if let error = error as? APIResponseError {
                    return self.refreshIDTokenIfExpired(error)
                        .flatMapLatest({ [weak self] isRefreshed -> Observable<JSONDictionary> in
                            guard let this = self else { return Observable.empty() }
                            if isRefreshed {
                                return this.upload(input, data: data)
                            } else {
                                return Observable.error(error)
                            }
                        })
                }
                throw error
            })
        }
}

// MARK: - Proccess response
extension APIService {

    fileprivate func processResponse(_ response: DataResponse<Any, AFError>,
                                     url: URL?) throws -> JSONDictionary {
        var error: Error = APIResponseError.invalidResponseData
        let responseObject = response.result
        if let data = response.request?.httpBody {
            print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) ?? "")
        }
        let statusCode: Int = response.response?.statusCode ?? 0
        var messageError = ""
        if let data = response.data {
            if let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? JSONDictionary {
                messageError = json["error.message"] as? String ?? ""
                if statusCode == 401 {
                    let absoluteString = (url?.absoluteString ?? "")
                    print("❌ [\(statusCode)] " + absoluteString)
                    NotificationCenter.default.post(name: .unauthorized, object: nil)
                } else if statusCode == 400 {
                    messageError = json["error.message"] as? String ?? ""
                }
            }
        }
        switch responseObject {
        case .success(let value) :
            if let json = value as? JSONDictionary {
                if statusCode == 400 {
                    error = APIResponseError.message(messageError)
                } else {
                    print("👍 [\(statusCode)] " + (url?.absoluteString ?? ""))
                    return json
                }
            }

            if let jsonArray = value as? JSONArray {
                if statusCode == 400 {
                    error = APIResponseError.message(messageError)
                } else {
                    print("👍 [\(statusCode)] " + (url?.absoluteString ?? ""))
                    return ["data": jsonArray]
                }
            }
        case .failure(let error as NSError):
            if statusCode >= 200 && statusCode < 300 {
                print("❌ [\(statusCode)] " + (url?.absoluteString ?? ""))
                return JSONDictionary()
            }
            if statusCode == 401 {
                messageError = "Email or password is incorrect"
                print("❌ [\(statusCode)] " + (url?.absoluteString ?? ""))
                throw APIResponseError.message(messageError)
            }
            print("❌ [\(statusCode)] " + (url?.absoluteString ?? ""))
            throw error
        default:
            break
        }
        print("❌ [\(statusCode)] " + (url?.absoluteString ?? ""))
        throw error
    }

    fileprivate func preprocessInput(_ input: APIBaseInput) -> Observable<APIBaseInput> {
        return Observable.deferred {
            if let urlParams = input.urlParams, !urlParams.keys.isEmpty {
                var urlString = input.urlString + "?"
                for (index, key) in Array(urlParams.keys).enumerated() {
                    if let value = urlParams[key] {
                        urlString += "\(key)" + "=" + "\(value)"
                        if index < urlParams.keys.count - 1 {
                            urlString += "&"
                        }
                    }
                }
                input.urlString = urlString
            }
            return Observable.just(input)
        }
    }

    fileprivate func preprocessUploadInput(_ input: APIUploadBaseInput) -> Observable<APIUploadBaseInput> {
        return Observable.deferred {
            return Observable.just(input)
        }
    }
}

// MARK: -
extension APIService {

    func refreshIDTokenIfExpired(_ error: APIResponseError) -> Observable<Bool> {
        switch error {
        case .unknown(let statusCode):
            switch statusCode {
            case 410:
                print("❌ ID Token expired. Refresh it and again")
            default:
                break
            }
        default:
            break
        }
        return Observable.just(false)
    }
}
