//
//  LanguageSettingLogics.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/14/21.
//

import Foundation

// MARK: DisplayLogic
protocol LanguageSettingDisplayLogic: DisplayLogic {
}

// MARK: BusinessLogic
protocol LanguageSettingBusinessLogic: BusinessLogic {

    var presenter: LanguageSettingPresentationLogic? { get set }

}

// MARK: PresentationLogic
protocol LanguageSettingPresentationLogic: PresentationLogic {

    var view: LanguageSettingDisplayLogic? { get set }
    var router: LanguageSettingRoutingLogic? { get set }

}

// MARK: RoutingLogic
protocol LanguageSettingRoutingLogic: RoutingLogic {
}
