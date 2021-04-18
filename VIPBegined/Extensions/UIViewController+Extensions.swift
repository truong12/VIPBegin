//
//  UIViewController+Extensions.swift
//  VIPBegined
//
//  Created by Le Tuan on 2/3/21.
//

import Foundation
import UIKit

extension UIViewController {

    var visibleViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.visibleViewController
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.visibleViewController
        } else if let presentedViewController = presentedViewController {
            return presentedViewController.visibleViewController
        } else {
            return self
        }
    }
}
