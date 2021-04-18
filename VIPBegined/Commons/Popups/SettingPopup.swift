//
//  SettingPopup.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/8/21.
//

import UIKit

class SettingPopup: BaseViewController {
    
    @IBOutlet fileprivate weak var titleLabel: BaseBoldLabel!
    @IBOutlet fileprivate weak var messageLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var settingButton: BaseBorderButton!

    var didConfirm: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigation()
    }
    
    override func performLocalizeTexts() {
        titleLabel.text = "popup.setting.title".localized
        messageLabel.text = "popup.setting.message".localized
        settingButton.setTitle("button.open.settings".localized, for: .normal)
    }

    override func addNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeAuthenLocation),
                                               name: .didChangeAuthenLocation,
                                               object: nil)
    }
}

// MARK: - Actions
extension SettingPopup {
    @IBAction fileprivate func settingAction(_ sender: Any) {
        AppNavigationManager.shared.goToSettingsApp()
    }

    @objc func didChangeAuthenLocation() {
        removeWithAnimate()
    }
}
