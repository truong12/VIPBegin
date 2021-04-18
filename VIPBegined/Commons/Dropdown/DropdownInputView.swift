//
//  DropdownInputView.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/14/21.
//

import UIKit

class DropdownInputView: UIView {

    @IBOutlet fileprivate weak var contentView: UIView!
    @IBOutlet fileprivate weak var titleLabel: BaseRegularLabel!

    var changeInput: (() -> Void)?
    var inputTitle: String? {
        didSet {
            titleLabel.text = inputTitle
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialConfig()
    }

    private func initialConfig() {
        Bundle.main.loadNibNamed(DropdownInputView.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @IBAction fileprivate func changeAction(_ sender: Any) {
        changeInput?()
    }
}
