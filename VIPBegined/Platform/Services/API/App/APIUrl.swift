//
//  APIUrl.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation

class APIURL {
    
    #if DEBUG
    private static let host = "https://ios-staging.dev-box.tech"
    #else
    private static let host = "https://ios.pod"
    #endif
    
    static let apiVersion = "/api/v1"
    
    static let urlRoot = host + apiVersion
    
    // App
    static let login = urlRoot + "/login"

    // Country
    static let country = "http://www.geognos.com/api/en/countries/info/VN.json"
}
