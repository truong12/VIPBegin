//
//  Double+Extensions.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/14/21.
//

import Foundation

extension Double {
    var weightValue: String {
        if self == 0 {
            return ""
        }
        return String(format: "%.0f", self)
    }
}
