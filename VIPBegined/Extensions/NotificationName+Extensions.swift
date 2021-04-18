//
//  NotificationName+Extensions.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation

extension Notification.Name {
    static let keyboardChangeFrame = Notification.Name("Keyboard Change Frame")
    static let didChangeStateOfServices = Notification.Name("Did Change State Of Services")
    static let unauthorized = Notification.Name("Authentication unauthorized")
    static let didChangeAuthenLocation = Notification.Name("Did Change Authen Location")
}
