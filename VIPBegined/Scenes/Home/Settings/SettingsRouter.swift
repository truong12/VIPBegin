//
//  SettingsRouter.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/9/21.
//

import Foundation
import UIKit

class SettingsRouter: SettingsRoutingLogic {

    weak var navigationController: UINavigationController?

    func goToLoginScreen() {
        AppNavigationManager.shared.setRootWhenSceneWillConnectToSession()
    }

    func goToLanguageSettingScreen() {
        let languageVC = LanguageSettingViewController.loadFromStoryboard()
        AppNavigationManager.shared.rootNavi?.pushViewController(languageVC, animated: true)
    }

}
