//
//  LanguageViewController.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/8/21.
//

import UIKit

class LanguageViewController: BaseViewController {

    fileprivate var interactor: LanguageInteractor!
    fileprivate var router: LanguageRouter!

    @IBOutlet fileprivate weak var languageDropdown: DropdownView!
    @IBOutlet fileprivate weak var titleLabel: BaseBoldLabel!
    @IBOutlet fileprivate weak var subTitleLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var nextButton: BaseBorderButton!
    @IBOutlet fileprivate weak var languageInputView: DropdownInputView!

    var selectedLanguage = DurianLanguage.init(rawValue: "en")

    override func viewDidLoad() {
        super.viewDidLoad()
        configDropDown()
    }

    override func performLocalizeTexts() {
        titleLabel.text = "language.title".localized
        subTitleLabel.text = "language.sub.title".localized

        let dropdownItems = DurianLanguage.listLaguage.map { language -> DropdownItem in
            return DropdownItem(decideType: language, title: language.description)
        }
        languageDropdown.setListItems(dropdownItems)
        languageInputView.inputTitle = selectedLanguage.description
        nextButton.setTitle("button.next".localized, for: .normal)
    }

    override func setupLogicLayers() {
        interactor = LanguageInteractor()
        router = LanguageRouter()
        let presenter = LanguagePresenter()
        presenter.view = self
        presenter.router = router
        router.navigationController = self.navigationController
        interactor.presenter = presenter
    }

}

// MARK: - Dropdown
extension LanguageViewController {
    func configDropDown() {
        languageDropdown.hidenDropdown()
        languageDropdown.didTapItem = { [weak self] item in
            guard let language = item.decideType as? DurianLanguage else { return }
            Bundle.setLanguage(lang: language.localizedValue)
            self?.selectedLanguage = language
            self?.languageInputView.inputTitle = language.description
            self?.performLocalizeTexts()
        }
        languageInputView.changeInput = { [weak self] in
            self?.languageDropdown.showDropDown()
        }
    }
}

// MARK: View
extension LanguageViewController: LanguageDisplayLogic {

}

// MARK: Action
extension LanguageViewController {
    @IBAction fileprivate func continueAction(_ sender: Any) {
        Bundle.setLanguage(lang: selectedLanguage.localizedValue)
        AppStatusManager.shared.decideLanguage = true
        router.goToTabbarScreen()
    }
}
