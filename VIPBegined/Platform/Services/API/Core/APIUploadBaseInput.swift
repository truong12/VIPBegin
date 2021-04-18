//
//  APIUploadBaseInput.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation
import Alamofire

class APIUploadBaseInput {

    let urlString: String
    var urlParams: [String : Any]?
    let method: HTTPMethod
    var parameters: [String: Any]?
    var encoding: ParameterEncoding
    let uploadData: [APIUploadData]
    var headers: HTTPHeaders = [:]
    
    init(urlString: String,
         method: HTTPMethod,
         parameters: [String: Any]?,
         urlParams: [String : Any]? = nil,
         uploadData: [APIUploadData]
    ) {
        self.urlString = urlString
        self.method = method
        self.parameters = parameters
        self.encoding = JSONEncoding.default
        self.urlParams = urlParams
        self.uploadData = uploadData
    }

    var url: URL? {
        return URL(string: urlString)
    }
}
