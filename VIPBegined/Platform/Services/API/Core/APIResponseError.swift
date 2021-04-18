//
//  APIResponseError.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation
import ObjectMapper

struct APIResponseErrorMessage {
    static let invalidResponseData = "Data is invalid"
    static let serverInternalError = "Server Internal Error"
}

// API
enum APIResponseError: Error {
    case invalidResponseData
    case expiredToken
    case error(response: APIBaseOutput)
    case unknown(statusCode: Int)
    case message(String)
    case serverInternalError
    // ...

    static func getErrorMessage(from error: Error) -> String {
        if let error = error as? APIResponseError {
            switch error {
            case .message(let message): return message
            case .invalidResponseData: return APIResponseErrorMessage.invalidResponseData
            case .serverInternalError: return APIResponseErrorMessage.serverInternalError
            default: return error.localizedDescription
            }
        } else {
            return error.localizedDescription
        }
    }
}

// Special Error
enum SpecialError: Error {
    case networkNotConnected
    case sessionExpired
}
