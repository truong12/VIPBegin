//
//  UIButton+Extensions.swift
//  VIPBegined
//
//  Created by Phat Tran on 3/11/21.
//

import Foundation
import UIKit

extension UIButton {
    func disable() {
        self.isUserInteractionEnabled = false
        self.backgroundColor = UIColor.gray
    }
    
    func enable() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.white
    }
}
