//
//  Bundle+Extensions.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/8/21.
//

import Foundation

extension Bundle {
    private static var bundle: Bundle!

    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = AppStatusManager.shared.localeIdentifier ?? "en"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }
        return bundle
    }

    public static func setLanguage(lang: String) {
        AppStatusManager.shared.localeIdentifier = lang
        if let path = Bundle.main.path(forResource: lang, ofType: "lproj") {
            bundle = Bundle(path: path)
        }
    }
}
