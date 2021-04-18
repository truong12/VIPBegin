//
//  LoginPresenter.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation

class LoginPresenter: LoginPresentationLogic {
    
    weak var view: LoginDislayLogic?
    var router: LoginRoutingLogic?

    func loginSuccess() {
        router?.changeRootScreen()
    }

    func loginFailure() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayLoginFailure()
        }
    }
}
