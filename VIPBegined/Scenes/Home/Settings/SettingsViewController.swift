//
//  SettingsViewController.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/9/21.
//

import UIKit

class SettingsViewController: BaseViewController {

    enum SettingType {
        case profile, language, sync
    }

    fileprivate var interactor: SettingsInteractor!
    fileprivate var router: SettingsRouter!

    @IBOutlet fileprivate weak var naviView: NaviBarView!
    @IBOutlet fileprivate weak var logoutButton: BaseBorderButton!
    @IBOutlet fileprivate weak var tableView: UITableView!

    var settings: [SettingType] = [.profile, .language, .sync]
    var user: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        interactor.getLocalUser()
    }

    override func setupLogicLayers() {
        interactor = SettingsInteractor()
        router = SettingsRouter()
        let presenter = SettingsPresenter()
        presenter.view = self
        presenter.router = router
        router.navigationController = self.navigationController
        interactor.presenter = presenter
    }

    override func performLocalizeTexts() {
        naviView.naviTitle = "settings.navi.title".localized
        logoutButton.setTitle("button.logout".localized, for: .normal)
        tableView.reloadData()
    }

}

// MARK: View
extension SettingsViewController: SettingsDisplayLogic {
    func displayUser(_ user: UserModel) {
        self.user = user
        tableView.reloadData()
    }
}

// MARK: Action
extension SettingsViewController {
    @IBAction fileprivate func logoutAction(_ sender: Any) {
        interactor.callLogout()
    }
}

// MARK: - UITableView
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(cellName: SettingProfileCell.className)
        tableView.registerNib(cellName: SettingCell.className)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if 0..<settings.count ~= indexPath.row {
            let setting = settings[indexPath.row]
            switch setting {
            case .profile:
                let cell = tableView.dequeueReusableCell(withClass: SettingProfileCell.self, for: indexPath)
                cell.user = user
                return cell
            case .language:
                let cell = tableView.dequeueReusableCell(withClass: SettingCell.self, for: indexPath)
                let language = DurianLanguage.init(rawValue: AppStatusManager.shared.localeIdentifier ?? "en")
                cell.display(with: "setting.language.settings".localized, and: language.description)
                return cell
            case .sync:
                let cell = tableView.dequeueReusableCell(withClass: SettingCell.self, for: indexPath)
                cell.display(with: "setting.data.auto.sync".localized, and: "-")
                return cell
            }
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if 0..<settings.count ~= indexPath.row {
            let setting = settings[indexPath.row]
            if setting == .language {
                router.goToLanguageSettingScreen()
            }
        }
    }
}
