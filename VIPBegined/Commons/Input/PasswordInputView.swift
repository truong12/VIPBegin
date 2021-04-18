//
//  PasswordInputView.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/7/21.
//

import UIKit

class PasswordInputView: UIView {

    @IBOutlet fileprivate weak var contentView: UIView!

    @IBOutlet fileprivate weak var titleLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var passwordTextField: BaseTextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialConfig()
    }

    private func initialConfig() {
        Bundle.main.loadNibNamed(PasswordInputView.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Language
        titleLabel.text = "login.password".localized
    }
}

extension PasswordInputView {
    func password() -> String {
        return passwordTextField.text ?? ""
    }
}
