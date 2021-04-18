//
//  AppNavagationManager.swift
//  VIPBegined
//
//  Created by Le Tuan on 2/3/21.
//

import Foundation
import UIKit

final class AppNavigationManager {

    static let shared = AppNavigationManager()

    fileprivate weak var mainTabbarController: UITabBarController?
    
    init() {
        configure()
    }
    
    var visibleClassName: String = ""

    var sceneDelegate: SceneDelegate? {
        return UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }

    var rootNavi: UINavigationController? {
        return sceneDelegate?.window?.rootViewController as? UINavigationController
    }

    var visibleViewController: UIViewController? {
        return sceneDelegate?.window?.rootViewController?.visibleViewController
    }

    fileprivate func configure() {

    }
}

extension AppNavigationManager {

    func setRootWhenSceneWillConnectToSession() {
        if AuthenticationLocalDatasource.shared.isAuthorized {
            if AppStatusManager.shared.decideLanguage {
                setRootIsTabbar()
            } else {
                setRootIsLanguageScreen()
            }
        } else {
            setRootIsLoginScreen()
        }
    }
    
    func setRootIsLoginScreen() {
        let loginVC = LoginViewController.loadFromStoryboard()
        let loginNavi = UINavigationController(rootViewController: loginVC)
        loginNavi.setNavigationBarHidden(true, animated: false)
        sceneDelegate?.window?.rootViewController = loginNavi
        sceneDelegate?.window?.makeKeyAndVisible()
    }

    func setRootIsLanguageScreen() {
        let languageVC = LanguageViewController.loadFromStoryboard()
        let languageNavi = UINavigationController(rootViewController: languageVC)
        languageNavi.setNavigationBarHidden(true, animated: false)
        sceneDelegate?.window?.rootViewController = languageNavi
        sceneDelegate?.window?.makeKeyAndVisible()
    }

    func setRootIsTabbar() {
        let tabBarVC = MainTabBarController.instance()
        let rootNavi = UINavigationController(rootViewController: tabBarVC)
        rootNavi.setNavigationBarHidden(true, animated: false)
        sceneDelegate?.window?.rootViewController = rootNavi
        sceneDelegate?.window?.makeKeyAndVisible()
        self.mainTabbarController = tabBarVC
    }
}

// MARK: - URL
extension AppNavigationManager {
    func goToSettingsApp() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            openExternalApp(settingsUrl)
        }
    }

    func openExternalApp(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

// MARK: - UINavigationController
extension AppNavigationManager {
    func createNavi(_ controller: BaseViewController) -> UINavigationController {
        let navi = UINavigationController(rootViewController: controller)
        navi.setNavigationBarHidden(true, animated: false)
        navi.modalPresentationStyle = .fullScreen
        return navi
    }
}
