//
//  ScannerPresenter.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/12/21.
//

import Foundation

class ScannerPresenter: ScannerPresentationLogic {

    weak var view: ScannerDisplayLogic?
    weak var router: ScannerRoutingLogic?

    func getUserSuccess(_ user: UserModel) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayUser(user)
        }
    }
}
