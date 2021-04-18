//
//  SettingsInteractor.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/9/21.
//

import Foundation
import RxSwift

class SettingsInteractor: SettingsBusinessLogic {

    var presenter: SettingsPresentationLogic?

    fileprivate let repository = SettingsRepository()
    fileprivate let authenticationReponsitory = AuthenticationRepository()

    let bag = DisposeBag()

    func getLocalUser() {
        authenticationReponsitory.getUser()
            .subscribe(onNext: { [weak self] user in
                self?.presenter?.getLocalUserSuccess(user)
            }, onError: { _ in })
        .disposed(by: bag)
    }

    func callLogout() {
        authenticationReponsitory.logOut()
        presenter?.callLogoutSuccess()
    }
}
