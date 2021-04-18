//
//  LanguageInteractor.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/8/21.
//

import Foundation
import RxSwift

class LanguageInteractor: LanguageBusinessLogic {

    var presenter: LanguagePresentationLogic?

    fileprivate let repository = LanguageRepository()
    let bag = DisposeBag()

}
