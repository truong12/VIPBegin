//
//  LanguageLogics.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/8/21.
//

import Foundation

// MARK: DisplayLogic
protocol LanguageDisplayLogic: DisplayLogic {
}

// MARK: BusinessLogic
protocol LanguageBusinessLogic: BusinessLogic {

    var presenter: LanguagePresentationLogic? { get set }

}

// MARK: PresentationLogic
protocol LanguagePresentationLogic: PresentationLogic {

    var view: LanguageDisplayLogic? { get set }
    var router: LanguageRoutingLogic? { get set }

}

// MARK: RoutingLogic
protocol LanguageRoutingLogic: RoutingLogic {
    func goToTabbarScreen()
}
