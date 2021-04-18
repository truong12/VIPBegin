//
//  BaseViewController.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogicLayers()
        setupUIStyles()

        // Resolve black navigation bar when popping
        self.extendedLayoutIncludesOpaqueBars = true

        NotificationCenter.default.addObserver(self, selector: #selector(serviceDidChangeState(_:)),
                                               name: .didChangeStateOfServices, object: nil)
        addNotificationCenter()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        performLocalizeTexts()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func setupLogicLayers() {

    }

    func setupUIStyles() {

    }

    // Add Notification Center
    func addNotificationCenter() {}

    // Set up language
    func performLocalizeTexts() {

    }

    func logDeinit() {
        print("\(className) DEINIT!!!")
    }

    deinit {
        logDeinit()
        NotificationCenter.default.removeObserver(self)
    }

    @objc func popToRootTabHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}

// MARK: - Load View From Storyboard
extension UIViewController {
    class func loadFromStoryboard() -> Self {
        return instantiateFromStoryboardHelper(self.className)
    }

    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
}

// MARK: - Actions
extension BaseViewController {

    @IBAction func backAction(_ sender: UIButton) {
        backToPreviousScreen()
    }

    func backToPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }

    func backToRootScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: Service States
extension BaseViewController {
    
    @objc func serviceDidChangeState(_ notification: Notification) {

    }
}

// MARK: - Navigation
extension BaseViewController {

    @objc func dismissAction() {
        dismiss(animated: true, completion: nil)
    }

    @objc func helpAction() {

    }

    @objc func baseBackAction() {
        navigationController?.popViewController(animated: true)
    }

    func showBackButton(_ naviColor: UIColor = .white,
                        title: String? = nil,
                        titleColor: UIColor = UIColor.black) {
        showNavigation(naviColor, title: title, titleColor: titleColor)
    }
    
    func showNavigation(_ naviColor: UIColor = .white, title: String? = nil,
                        titleColor: UIColor) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = titleColor
        navigationController?.navigationBar.barTintColor = naviColor
    }
    
    func hideNavigation() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.isTranslucent = true

        AppNavigationManager.shared.rootNavi?.setNavigationBarHidden(true, animated: false)
        AppNavigationManager.shared.rootNavi?.navigationBar.isTranslucent = true
    }
}

// MARK: - Handle Keyboard
extension BaseViewController {

    func addKeyboardListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardDidShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc fileprivate func handleKeyboardDidShow(notification: Notification) {
        if let frame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            guard let tabbarHeight = tabBarController?.tabBar.frame.size.height else {
                prepareUpdateViewWithMarginBottom(frame.size.height - view.safeAreaInsets.bottom)
                return
            }
            prepareUpdateViewWithMarginBottom(frame.size.height - tabbarHeight)
        }
    }

    @objc fileprivate func handleKeyboardWillHide(notification: Notification) {
        prepareUpdateViewWithMarginBottom(0)
    }

    fileprivate func prepareUpdateViewWithMarginBottom(_ marginBottom: CGFloat) {
        NotificationCenter.default.post(name: .keyboardChangeFrame, object: nil)
        updateViewWithMarginBottom(marginBottom)
    }

    @objc func updateViewWithMarginBottom(_ marginBottom: CGFloat) {
        
    }
}

extension BaseViewController {
    // Remove Animation for UIController
    func removeWithAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: { (finished : Bool)  in
            if (finished) {
                self.dismiss(animated: false, completion: nil)
            }
        })
    }

    func removeWithAnimate(callBack: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: { (finished : Bool)  in
            if (finished) {
                self.dismiss(animated: false, completion: {
                    callBack?(finished)
                })
            }
        })
    }
}
