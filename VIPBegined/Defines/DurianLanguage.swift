//
//  VIPBeginedLanguage.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/14/21.
//

import Foundation

public enum DurianLanguage {

    case english
    case malaysia
    case unknown

    init(rawValue value: String) {
        var temp = value
        if temp.isEmpty {
            temp = NSLocale.current.regionCode ?? DurianLanguage.english.localizedValue
        }
        switch temp {
        case "en": self = DurianLanguage.english
        case "ms": self = DurianLanguage.malaysia
        default: self = DurianLanguage.english
        }
    }

    var description: String {
        switch self {
        case .english: return "language.english".localized
        case .malaysia: return "language.malaysia".localized
        default:
            return "Unknowned"
        }
    }

    var rawValue: String {
        switch self {
        case .english: return "en"
        case .malaysia: return "ms"
        default:
            return "Unknowned"
        }
    }

    var localizedValue: String {
        switch self {
        case .english: return "en"
        case .malaysia: return "ms"
        default:
            return "Unknowned"
        }
    }
}

extension DurianLanguage {
    static var listLaguage: [DurianLanguage] {
        return [
            DurianLanguage.init(rawValue: "en"),
            DurianLanguage.init(rawValue: "ms")
        ]
    }

    static var defaultLanguage: DurianLanguage {
        return DurianLanguage.init(rawValue: "en")
    }

    func compareLaguage( lang: DurianLanguage) -> Bool {
        if self.rawValue == lang.rawValue {
            return true
        }
        return false
    }
}
