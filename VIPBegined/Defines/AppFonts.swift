//
//  AppFonts.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation
import UIKit

struct AppFonts {

    struct FamilyName {
        static let latoBold = "Lato-Bold"
        static let latoRegular = "Lato-Regular"
    }

    static let latoBold14 = latoBold(14)
    static let latoRegular14 = latoRegular(14)

}

// MARK: - Methods
extension AppFonts {
    static func latoBold(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FamilyName.latoBold, size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }

    static func latoRegular(_ fontSize: CGFloat) -> UIFont {
        return UIFont(name: FamilyName.latoRegular, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}
