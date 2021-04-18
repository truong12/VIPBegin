//
//  UserInputView.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/7/21.
//

import UIKit

class UserInputView: UIView {

    @IBOutlet fileprivate weak var contentView: UIView!

    @IBOutlet fileprivate weak var titleLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var userTextField: BaseTextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialConfig()
    }

    private func initialConfig() {
        Bundle.main.loadNibNamed(UserInputView.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Language
        titleLabel.text = "login.user.id".localized
    }
}

extension UserInputView {
    func userId() -> String {
        return userTextField.text ?? ""
    }
}
