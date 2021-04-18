//
//  DropdownView.swift
//  Reward
//
//  Created by Nguyen Truong on 2/25/21.
//  Copyright © 2021 Nguyen Truong. All rights reserved.
//

import Foundation
import UIKit

struct DropdownItem {
    var decideType: Any
    var title: String

    init(decideType: Any, title: String) {
        self.decideType = decideType
        self.title = title
    }
}

class DropdownView: UIView {

    @IBOutlet fileprivate weak var contentView: UIView!
    @IBOutlet fileprivate weak var stackView: UIStackView!
    @IBOutlet fileprivate weak var stackContainerView: UIView!

    var items: [DropdownItem] = []
    var didTapItem: ((DropdownItem) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialConfig()
    }

    private func initialConfig() {
        Bundle.main.loadNibNamed(DropdownView.className, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.hidden()
        self.backgroundColor = .clear

        if let drawView = self.viewWithTag(99) {
            stackContainerView.translatesAutoresizingMaskIntoConstraints = false
            stackContainerView.topAnchor.constraint(equalTo: drawView.topAnchor).isActive = true
            stackContainerView.rightAnchor.constraint(equalTo: drawView.rightAnchor).isActive = true
            stackContainerView.leftAnchor.constraint(equalTo: drawView.leftAnchor).isActive = true
        }
    }

    func setListItems(_ items: [DropdownItem]) {
        self.items = items
        for item in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(item)
            item.removeFromSuperview()
        }
        for (index, item) in items.enumerated() {
            let titleView = DropdownTitleView()
            titleView.item = item
            if index == items.count - 1 {
                titleView.lineIsHidden = true
            } else {
                titleView.lineIsHidden = false
            }
            titleView.delegate = self
            stackView.addArrangedSubview(titleView)
        }
    }

    func hidenDropdown() {
        self.hidden()
    }

    func showDropDown() {
        self.show()
    }

    @IBAction fileprivate func dismissAction(_ sender: Any) {
        hidenDropdown()
    }
}

extension DropdownView: DropdownTitleViewDelegate {
    func didTapItem(_ item: DropdownItem) {
        didTapItem?(item)
        hidenDropdown()
    }
}
