//
//  API_Authentication.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21À
//

import Foundation
import RxSwift
import ObjectMapper

extension APIService {
    
    func login(_ input: LoginInput) -> Observable<LoginOutput> {
        return request(input)
    }
}

class LoginInput: APIBaseInput {
    
    init(email: String, password: String) {
        let params = [
            "email": email,
            "password": password
        ]
        super.init(urlString: APIURL.login, method: .post, parameters: params)
    }
}

class LoginOutput: APIBaseOutput {
    
    var user: UserModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        user <- map["data"]
    }
}
