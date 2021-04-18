//
//  AppStatusManager.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/8/21.
//

import Foundation

final class AppStatusManager: NSObject {
    static let shared = AppStatusManager()
    private let userDefaults = UserDefaults.standard

    struct Key {
        static let localeIdentifier = "LOCALE_IDENTIFIER"
        static let decideLanguage = "DECIDE_LANGUAGE"
    }
}

// MARK: - Langugage
extension AppStatusManager {
    var localeIdentifier: String? {
        get {
            return userDefaults.string(forKey: Key.localeIdentifier)
        }
        set {
            userDefaults.set(newValue, forKey: Key.localeIdentifier)
            userDefaults.synchronize()
        }
    }

    var decideLanguage: Bool {
        get {
            return userDefaults.bool(forKey: Key.decideLanguage)
        }
        set {
            userDefaults.set(newValue, forKey: Key.decideLanguage)
            userDefaults.synchronize()
        }
    }
}
