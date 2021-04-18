//
//  ScannerInteractor.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/12/21.
//

import Foundation
import RxSwift

class ScannerInteractor: ScannerBusinessLogic {

    var presenter: ScannerPresentationLogic?

    fileprivate let repository = ScannerRepository()
    fileprivate let authenticationRepository = AuthenticationRepository()

    let bag = DisposeBag()

    func getUser() {
        authenticationRepository.getUser()
            .subscribe(onNext: { [weak self] user in
                self?.presenter?.getUserSuccess(user)
            }, onError: { _ in
                // TODOs:
            })
        .disposed(by: bag)
    }

    func getFarmerFromQRCode(_ qrCode: String) {
        // TODOs: Proecss qrcode
    }
}
