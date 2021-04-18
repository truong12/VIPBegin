//
//  EntriesLogics.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/12/21.
//

import Foundation

// MARK: DisplayLogic
protocol EntriesDisplayLogic: DisplayLogic {
    func displayCountry(_ country: CountryModel)
}

// MARK: BusinessLogic
protocol EntriesBusinessLogic: BusinessLogic {

    var presenter: EntriesPresentationLogic? { get set }

    func getCountry()

}

// MARK: PresentationLogic
protocol EntriesPresentationLogic: PresentationLogic {

    var view: EntriesDisplayLogic? { get set }
    var router: EntriesRoutingLogic? { get set }

    func getCountrySuccess(_ country: CountryModel)

}

// MARK: RoutingLogic
protocol EntriesRoutingLogic: RoutingLogic {
}
