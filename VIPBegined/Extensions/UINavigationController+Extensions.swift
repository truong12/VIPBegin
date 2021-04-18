//
//  UINavigationController+Extensions.swift
//  VIPBegined
//
//  Created by Le Tuan on 2/3/21.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func displayPopup(viewController: UIViewController,
                      backgroundColor: UIColor? = UIColor.black.withAlphaComponent(0.5),
                      animated: Bool = false) {
        DispatchQueue.main.async {
            viewController.view.backgroundColor = backgroundColor
            viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(navigationController, animated: animated, completion: nil)
        }
    }
}
