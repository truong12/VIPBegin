//
//  TabBarItem.swift
//  VIPBegined
//
//  Created by Le Tuan on 3/9/20.
//

import Foundation
import UIKit

enum TabBarItemType {
    case scanner
    case entries
    case settings
}

extension TabBarItemType {

    var image: UIImage? {
        switch self {
        case .scanner: return UIImage(named: "ic_tabbar_home")
        case .entries: return UIImage(named: "ic_tabbar_gift")
        case .settings: return UIImage(named: "ic_tabbar_more")
        }
    }

    var title: String {
        switch self {
        case .scanner: return "tabbar.scanner".localized
        case .entries: return "tabbar.entries".localized
        case .settings: return "tabbar.settings".localized
        }
    }

    var tag: Int {
        switch self {
        case .scanner: return 0
        case .entries: return 1
        case .settings: return 2
        }
    }

    var tabBarItem: UITabBarItem {
        let item = UITabBarItem(title: title,
                                image: image?.withRenderingMode(.alwaysTemplate),
                                selectedImage: image?.withRenderingMode(.alwaysTemplate))
        item.tag = tag
        item.setTitleTextAttributes([
            NSAttributedString.Key.font: AppFonts.latoRegular14
        ], for: .normal)
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -7)
        item.imageInsets = UIEdgeInsets(top: -3, left: .zero, bottom: .zero, right: .zero)
        return item
    }
}
