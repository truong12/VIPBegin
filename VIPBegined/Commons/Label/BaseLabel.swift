//
//  BaseLabel.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/7/21.
//

import UIKit

class BaseBoldLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont(name: "Lato-Bold", size: self.font.pointSize)
    }
}

class BaseRegularLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont(name: "Lato-Regular", size: self.font.pointSize)
    }
}
