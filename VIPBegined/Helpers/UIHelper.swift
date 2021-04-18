//
//  UIHelper.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation
import JGProgressHUD

final class UIHelper {

    static let shared = UIHelper()

    var hub: JGProgressHUD?
}

// MARK: - Loading
extension UIHelper {
    
    func showLoading(_ view: UIView? = nil) {
        let container = view != nil ? view : AppNavigationManager.shared.visibleViewController?.view
        DispatchQueue.main.async { [unowned self] in
            if let container = container {
                if self.hub == nil {
                    self.hub = JGProgressHUD(style: .extraLight)
                    var indicatorView: UIActivityIndicatorView?
                    if #available(iOS 13.0, *) {
                        indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
                    } else {
                        indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
                    }
                    indicatorView?.color = UIColor.gray
                    indicatorView?.startAnimating()
                    self.hub?.indicatorView = JGProgressHUDImageIndicatorView(contentView: indicatorView)
                }
                self.hub?.show(in: container)
            }
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.hub?.dismiss()
        }
    }
}

extension UIHelper {
    static var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    func isNewVersion(_ version: String) -> Bool {
        if version.compare(UIHelper.appVersion, options: .numeric) == .orderedDescending {
            return true
        }
        return false
    }
}
