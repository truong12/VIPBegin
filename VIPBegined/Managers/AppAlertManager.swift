//
//  AppAlertManager.swift
//  VIPBegined
//
//  Created by Phat Tran on 3/9/21.
//

import Foundation
import UIKit

final class AppAlertManager {
    
    static let shared = AppAlertManager()
    
}

extension AppAlertManager {
    
    func displayConfirm(with message: String, callBack: ((UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "alert.button.ok".localized, style: .default, handler: callBack))
        AppNavigationManager.shared.visibleViewController?.present(alertVC, animated: true, completion: nil)
    }
    
    func displayGotItConfirm(with message: String, callBack: ((UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "scan.wrong.qr.code.got.it".localized, style: .default, handler: callBack)
        alertVC.addAction(action)
        AppNavigationManager.shared.visibleViewController?.present(alertVC, animated: true, completion: nil)
    }
    
}

// MARK: - Go Settings app
extension AppAlertManager {
    func openSettingAlert(withTitle title: String,
                          andMessage message: String,
                          fromViewController viewController: UIViewController?,
                          callBack: ((UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: AppAlert.Button.cancelButton, style: .default, handler: callBack)
        let settingAction = UIAlertAction(title: AppAlert.Button.settingButton, style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        })
        alertVC.addAction(cancelAction)
        alertVC.addAction(settingAction)
        viewController?.present(alertVC, animated: true, completion: nil)
    }
}
