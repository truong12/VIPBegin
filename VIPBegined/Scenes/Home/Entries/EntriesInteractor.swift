//
//  EntriesInteractor.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/12/21.
//

import Foundation
import RxSwift

class EntriesInteractor: EntriesBusinessLogic {

    var presenter: EntriesPresentationLogic?

    fileprivate let repository = EntriesRepository()
    let bag = DisposeBag()

    func getCountry() {
        repository.getCountry().subscribe(onNext: { [weak self] country in
            self?.presenter?.getCountrySuccess(country)
        }, onError: { _ in
            // TODOs:
        }).disposed(by: bag)
    }

}
