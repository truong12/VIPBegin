//
//  MainTabBarViewController.swift
//  VIPBegined
//
//  Created by Le Tuan on 3/9/20.
//

import UIKit

class MainTabBarController: UITabBarController {

    override var selectedIndex: Int {
        didSet {
            refreshTitleWithSelectedIndex(selectedIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshTitleWithSelectedIndex(selectedIndex)
        tabBar.addShadow(offset: CGSize(width: 0, height: -3), color: UIColor.black, radius: 10, opacity: 0.05)

        for subViewsTabbar in tabBar.subviews {
            for badgeView in subViewsTabbar.subviews {
                if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                    badgeView.layer.transform = CATransform3DIdentity
                    badgeView.layer.transform = CATransform3DMakeTranslation(-3.0, 3.0, 1.0)
                }
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let newTabBarHeight: CGFloat = tabBar.frame.height + 8.0
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        tabBar.frame = newFrame
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        refreshTitleWithSelectedIndex(item.tag)
        for subViewsTabbar in tabBar.subviews {
            for badgeView in subViewsTabbar.subviews {
                if NSStringFromClass(badgeView.classForCoder) == "_UIBadgeView" {
                    badgeView.layer.transform = CATransform3DIdentity
                    badgeView.layer.transform = CATransform3DMakeTranslation(-3.0, 3.0, 1.0)
                }
            }
        }
    }

    func refreshTitleWithSelectedIndex(_ index: Int) {
        guard let viewControllers = viewControllers else {
            return
        }
        for (subindex, viewController) in viewControllers.enumerated() {
            if subindex == index {
                viewController.tabBarItem.setTitleTextAttributes([
                    .font: AppFonts.latoBold14], for: .normal)
            } else {
                viewController.tabBarItem.setTitleTextAttributes([
                    .font: AppFonts.latoRegular14], for: .normal)
            }
        }
    }
}

extension MainTabBarController {

    class func instance() -> MainTabBarController {
        let tabbarVC = MainTabBarController()
        let viewControllers = generateViewControllers()
        tabbarVC.viewControllers = viewControllers
        return tabbarVC
    }

    class func generateViewControllers() -> [UINavigationController] {
        return mainTabbarViewControllers()
    }

    class func mainTabbarViewControllers() -> [UINavigationController] {

        let scannerVC = ScannerViewController.loadFromStoryboard()
        scannerVC.tabBarItem = TabBarItemType.scanner.tabBarItem
        let scannerNavi = UINavigationController(rootViewController: scannerVC)
        scannerNavi.setNavigationBarHidden(true, animated: false)

        let entriesVC = EntriesViewController.loadFromStoryboard()
        entriesVC.tabBarItem = TabBarItemType.entries.tabBarItem
        let entriesNavi = UINavigationController(rootViewController: entriesVC)
        entriesNavi.setNavigationBarHidden(true, animated: false)

        let settingsVC = SettingsViewController.loadFromStoryboard()
        settingsVC.tabBarItem = TabBarItemType.settings.tabBarItem
        let settingsNavi = UINavigationController(rootViewController: settingsVC)
        settingsNavi.setNavigationBarHidden(true, animated: false)

        let viewControllers = [scannerNavi, entriesNavi, settingsNavi]
        return viewControllers
    }
}
