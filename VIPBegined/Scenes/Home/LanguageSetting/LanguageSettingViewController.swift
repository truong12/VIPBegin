//
//  LanguageSettingViewController.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/14/21.
//

import UIKit

class LanguageSettingViewController: BaseViewController {

    fileprivate var interactor: LanguageSettingInteractor!
    fileprivate var router: LanguageSettingRouter!

    @IBOutlet fileprivate weak var naviView: NaviBarBackView!
    @IBOutlet fileprivate weak var titleLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var tableView: UITableView!

    let languages: [DurianLanguage] = DurianLanguage.listLaguage

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        naviView.didBack = { [weak self] in
            self?.baseBackAction()
        }
    }

    override func setupLogicLayers() {
        interactor = LanguageSettingInteractor()
        router = LanguageSettingRouter()
        let presenter = LanguageSettingPresenter()
        presenter.view = self
        presenter.router = router
        router.navigationController = self.navigationController
        interactor.presenter = presenter
    }

    override func performLocalizeTexts() {
        naviView.naviTitle = "language.setting.navi.title".localized
        titleLabel.text = "language.setting.select.preferred.language".localized
    }

}

// MARK: View
extension LanguageSettingViewController: LanguageSettingDisplayLogic {

}

// MARK: Action
extension LanguageSettingViewController {

}

// MARK: - UITableView
extension LanguageSettingViewController: UITableViewDelegate, UITableViewDataSource {

    func configTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(cellName: LanguageSettingCell.className)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: LanguageSettingCell.self, for: indexPath)
        if 0..<languages.count ~= indexPath.row {
            cell.language = languages[indexPath.row]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if 0..<languages.count ~= indexPath.row {
            let language = languages[indexPath.row]
            Bundle.setLanguage(lang: language.localizedValue)
            performLocalizeTexts()
            tableView.reloadData()
        }
    }
}
