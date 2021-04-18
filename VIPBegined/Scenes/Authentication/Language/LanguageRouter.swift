//
//  LanguageRouter.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/8/21.
//

import Foundation
import UIKit

class LanguageRouter: LanguageRoutingLogic {

    weak var navigationController: UINavigationController?

    func goToTabbarScreen() {
        AppNavigationManager.shared.setRootIsTabbar()
    }
}
