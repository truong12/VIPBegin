//
//  SettingsPresenter.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/9/21.
//

import Foundation

class SettingsPresenter: SettingsPresentationLogic {

    weak var view: SettingsDisplayLogic?
    weak var router: SettingsRoutingLogic?

    func getLocalUserSuccess(_ user: UserModel) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayUser(user)
        }
    }

    func callLogoutSuccess() {
        router?.goToLoginScreen()
    }
}
