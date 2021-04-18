//
//  BaseTextField.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/7/21.
//

import UIKit

class BaseTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont(name: "Lato-Regular", size: self.font?.pointSize ?? 12)
    }
}
