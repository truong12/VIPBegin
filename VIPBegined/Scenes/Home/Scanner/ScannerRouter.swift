//
//  ScannerRouter.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/12/21.
//

import Foundation
import UIKit

class ScannerRouter: ScannerRoutingLogic {

    var interactor: ScannerBusinessLogic?
    weak var navigationController: UINavigationController?

    func goToQRCodeScreen() {
        let qrVC = ScanQRViewController.loadFromStoryboard()
        qrVC.delegate = self
        AppNavigationManager.shared.rootNavi?.displayPopup(viewController: qrVC,
                                                           backgroundColor: UIColor.systemYellow,
                                                           animated: false)
    }

}

extension ScannerRouter: ScanQRViewControllerDelegate {
    func scanQRDidReceive(_ decodeCode: String) {
        interactor?.getFarmerFromQRCode(decodeCode)
    }
}
