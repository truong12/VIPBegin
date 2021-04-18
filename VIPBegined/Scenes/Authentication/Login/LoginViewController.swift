//
//  LoginViewController.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import UIKit
import DropDown

class LoginViewController: BaseViewController {
    
    fileprivate var interactor: LoginInteractor!
    fileprivate var router: LoginRouter!

    @IBOutlet fileprivate weak var userInput: UserInputView!
    @IBOutlet fileprivate weak var passwordInput: PasswordInputView!
    @IBOutlet fileprivate weak var loginButton: BaseBorderButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigation()
    }
    
    override func setupUIStyles() {
        loginButton.setTitle("button.login".localized, for: .normal)
    }
    
    override func setupLogicLayers() {
        interactor = LoginInteractor()
        router = LoginRouter()
        let presenter = LoginPresenter()
        presenter.view = self
        presenter.router = router
        presenter.router?.navigationController = navigationController
        interactor.presenter = presenter
    }
}

// MARK: - LoginDisplayLogic
extension LoginViewController: LoginDislayLogic {
    func displayLoginFailure() {
        loginButton.hideLoading()
    }
}

// MARK: - Actions
extension LoginViewController {
    @IBAction fileprivate func loginAction(_ sender: Any) {
        let email = userInput.userId()
        let password =  passwordInput.password()

        loginButton.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.interactor.login(with: email, and: password)
        }
    }
}
