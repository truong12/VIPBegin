//
//  SettingsLogics.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/9/21.
//

import Foundation

// MARK: DisplayLogic
protocol SettingsDisplayLogic: DisplayLogic {
    func displayUser(_ user: UserModel)
}

// MARK: BusinessLogic
protocol SettingsBusinessLogic: BusinessLogic {

    var presenter: SettingsPresentationLogic? { get set }

    func getLocalUser()
    func callLogout()

}

// MARK: PresentationLogic
protocol SettingsPresentationLogic: PresentationLogic {

    var view: SettingsDisplayLogic? { get set }
    var router: SettingsRoutingLogic? { get set }

    func getLocalUserSuccess(_ user: UserModel)
    func callLogoutSuccess()
}

// MARK: RoutingLogic
protocol SettingsRoutingLogic: RoutingLogic {
    func goToLoginScreen()
    func goToLanguageSettingScreen()
}
