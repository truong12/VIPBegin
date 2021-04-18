//
//  NaviBarView.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/9/21.
//

import UIKit

class NaviBarView: UIView {

    @IBOutlet fileprivate weak var contentView: UIView!
    @IBOutlet fileprivate weak var titleLabel: BaseBoldLabel!

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
        Bundle.main.loadNibNamed(NaviBarView.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
