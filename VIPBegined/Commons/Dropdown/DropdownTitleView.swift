//
//  DropdownTitleView.swift
//  Reward
//
//  Created by Nguyen Truong on 2/25/21.
//  Copyright © 2021 Nguyen Truong. All rights reserved.
//

import Foundation
import UIKit

protocol DropdownTitleViewDelegate: class {
    func didTapItem(_ item: DropdownItem)
}

class DropdownTitleView: UIView {

    @IBOutlet fileprivate weak var contentView: UIView!
    @IBOutlet fileprivate weak var titleLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var lineView: UIView!

    weak var delegate: DropdownTitleViewDelegate?

    var item: DropdownItem? {
        didSet {
            titleLabel.text = item?.title
            self.layoutIfNeeded()
        }
    }

    var lineIsHidden = true {
        didSet {
            lineView.isHidden = lineIsHidden
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
        Bundle.main.loadNibNamed(DropdownTitleView.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @IBAction fileprivate func itemAction(_ sender: Any) {
        guard let item = self.item else { return }
        delegate?.didTapItem(item)
    }
}
