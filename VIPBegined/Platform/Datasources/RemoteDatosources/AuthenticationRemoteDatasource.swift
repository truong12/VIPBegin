//
//  AuthenticationRemoteDatasource.swift
//  VIPBegined
//
//  Created by Le Tuan on 2/3/21.
//

import Foundation
import RxSwift

class AuthenticationRemoteDatasource: RemoteDatasource {

    // TODOs:
    func login(email: String, password: String) -> Observable<UserModel> {

        if let user = DraftHelpers.shared.draftUsers().first(where: {$0.id == email}) {
            return Observable.just(user)
        } else {
            return Observable.error(APIResponseError.message("User not found."))
        }

        /*
         let input = LoginInput(email: email, password: password)
         return APIService.shared.login(input).map { output -> UserModel in
         if let user = output.user {
         return user
         }
         throw APIResponseError.message(output.message)
         }
         */
    }
}
