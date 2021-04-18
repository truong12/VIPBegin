//
//  EntriesPresenter.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/12/21.
//

import Foundation

class EntriesPresenter: EntriesPresentationLogic {

    weak var view: EntriesDisplayLogic?
    weak var router: EntriesRoutingLogic?

    func getCountrySuccess(_ country: CountryModel) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayCountry(country)
        }
    }
    
}
