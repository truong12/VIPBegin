//
//  LanguageSettingInteractor.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/14/21.
//

import Foundation
import RxSwift

class LanguageSettingInteractor: LanguageSettingBusinessLogic {

    var presenter: LanguageSettingPresentationLogic?

    fileprivate let repository = LanguageSettingRepository()
    let bag = DisposeBag()

}
