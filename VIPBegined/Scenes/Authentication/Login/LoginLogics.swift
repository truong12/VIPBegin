//
//  LoginLogics.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation

// MARK: - Display Logic
protocol LoginDislayLogic: DisplayLogic {
    func displayLoginFailure()
}

// MARK: - Business Logic
protocol LoginBusinessLogic: BusinessLogic {
    var presenter: LoginPresentationLogic? { get set }

    func login(with email: String, and password: String)
}

// MARK: - Presentation Logic
protocol LoginPresentationLogic: PresentationLogic {
    var view: LoginDislayLogic? { get set }
    var router: LoginRoutingLogic? { get set }

    func loginSuccess()
    func loginFailure()

}

// MARK: - Routing Logic
protocol LoginRoutingLogic: RoutingLogic {
    func changeRootScreen()
}
