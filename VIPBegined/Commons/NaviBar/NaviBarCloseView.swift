//
//  NaviBarCloseView.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/12/21.
//

import UIKit

class NaviBarCloseView: UIView {

    @IBOutlet fileprivate weak var contentView: UIView!
    @IBOutlet fileprivate weak var titleLabel: BaseBoldLabel!

    var didClose: (() -> Void)?
    var naviTitle: String = "" {
        didSet {
            self.titleLabel.text = naviTitle
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
        Bundle.main.loadNibNamed(NaviBarCloseView.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @IBAction fileprivate func closeAction(_ sender: Any) {
        didClose?()
    }
}
