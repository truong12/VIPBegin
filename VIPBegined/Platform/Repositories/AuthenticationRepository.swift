//
//  AuthenticationRepository.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation
import RxSwift

protocol AuthenticationRepositoryType: Repository {
    func logIn(email: String, password: String) -> Observable<UserEntity>
    func register(email: String, password: String) -> Observable<UserEntity>
    func logOut(email: String, password: String) -> Observable<Bool>

    // User
    func getUser() -> Observable<UserModel>
    func logOut()
}

class AuthenticationRepository: AuthenticationRepositoryType {
    
    fileprivate var remoteDatasource = AuthenticationRemoteDatasource()
    fileprivate var localDatasource = AuthenticationLocalDatasource()
    
    func logIn(email: String, password: String) -> Observable<UserEntity> {
        return remoteDatasource.login(email: email, password: password).map { model -> UserEntity in
            AuthenticationLocalDatasource.shared.cacheUser(model)
            return model.self
        }
    }
    func register(email: String, password: String) -> Observable<UserEntity> {
        // TODOs
        return Observable.just(UserModel())
    }
    
    func logOut(email: String, password: String) -> Observable<Bool> {
        // TODOs
        return Observable.just(true)
    }

    // MARK: - User
    func getUser() -> Observable<UserModel> {
        if let user = localDatasource.getCachedUser() {
            return Observable.just(user)
        }
        return Observable.error(APIResponseError.message("User not found!"))
    }

    func logOut() {
        localDatasource.removeAppUserFileName()
    }
}
