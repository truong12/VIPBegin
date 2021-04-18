//
//  ScannerViewController.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/12/21.
//

import UIKit

class ScannerViewController: BaseViewController {

    fileprivate var interactor: ScannerInteractor!
    fileprivate var router: ScannerRouter!

    @IBOutlet fileprivate weak var naviView: NaviBarView!
    @IBOutlet fileprivate weak var welcomeLabel: BaseBoldLabel!
    @IBOutlet fileprivate weak var qrButton: BaseBorderButton!

    var user: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getUser()
    }

    override func setupLogicLayers() {
        interactor = ScannerInteractor()
        router = ScannerRouter()
        let presenter = ScannerPresenter()
        presenter.view = self
        presenter.router = router
        router.navigationController = self.navigationController
        interactor.presenter = presenter
        router.interactor = interactor
    }

    override func performLocalizeTexts() {
        qrButton.setTitle("button.lauch.qr.scanner".localized, for: .normal)
        naviView.naviTitle = "scanner.navi.title".localized
        displayUserInfo()
    }

}

// MARK: View
extension ScannerViewController: ScannerDisplayLogic {
    func displayUser(_ user: UserModel) {
        self.user = user
        displayUserInfo()
    }

    fileprivate func displayUserInfo() {
        guard let user = self.user else { return }
        welcomeLabel.text = user.welcome
    }
}

// MARK: Action
extension ScannerViewController {
    @IBAction fileprivate func qrAction(_ sender: Any) {
        router.goToQRCodeScreen()
    }
}
