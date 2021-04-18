//
//  NSObject+Extensions.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation

extension NSObject {

    @objc var className: String {
        return String(describing: type(of: self))
    }

    @objc class var className: String {
        return String(describing: self)
    }
}
