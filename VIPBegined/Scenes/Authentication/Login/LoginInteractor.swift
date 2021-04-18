//
//  LoginInteractor.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation
import RxSwift

class LoginInteractor: LoginBusinessLogic {
    
    var presenter: LoginPresentationLogic?
    
    fileprivate let repository = AuthenticationRepository()
    let bag = DisposeBag()

    func login(with email: String, and password: String) {
        repository.logIn(email: email, password: password).subscribe(onNext: { [weak self] _ in
            self?.presenter?.loginSuccess()
        }, onError: { [weak self] _ in
            self?.presenter?.loginFailure()
        }).disposed(by: bag)
    }
}
