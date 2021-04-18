//
//  LoginRouter.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation
import UIKit

class LoginRouter: LoginRoutingLogic {
    
    weak var navigationController: UINavigationController?
    
    func changeRootScreen() {
        AppNavigationManager.shared.setRootWhenSceneWillConnectToSession()
    }
}
