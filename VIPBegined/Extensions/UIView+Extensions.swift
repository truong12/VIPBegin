//
//  UIView+Extensions.swift
//  VIPBegined
//
//  Created by Le Tuan on 2/3/21.
//

import Foundation
import UIKit

// MARK: - IBInspectables
extension UIView {

    @IBInspectable var radius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.black.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}

// MARK: - Shadow
extension UIView {
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        removeShadow()
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }

    func addShadowDefault() {
        addShadow(offset: CGSize(width: 0, height: 1), color: UIColor.black, radius: 4, opacity: 0.1)
    }

    func removeShadow() {
        layer.shadowOffset = CGSize(width: 0 , height: 0)
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowRadius = 0.0
        layer.shadowOpacity = 0.00
    }
}

extension UIView {

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIView {

    func fadeIn(duration: TimeInterval, startAlpha: CGFloat = 0) {
        self.alpha = startAlpha
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: { [unowned self] in
                        self.alpha = 1.0
            }, completion: nil)
    }

    func fadeOut(duration: TimeInterval, startAlpha: CGFloat = 1) {
        self.alpha = startAlpha
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: { [unowned self] in
                        self.alpha = 0.0
            }, completion: nil)
    }
}

extension UIView {

    func removeWithAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 0.0
        }, completion: { (finished : Bool)  in
            if (finished) {
                self.removeFromSuperview()
            }
        })
    }

    func removeWithAnimate(callBack: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 0.0
        }, completion: { (finished : Bool)  in
            if (finished) {
                self.removeFromSuperview()
                callBack?(finished)
            }
        })
    }
}

// MARK: Hidden
extension UIView {
    func hidden() {
        self.isHidden = true
    }

    func show() {
        self.isHidden = false
    }
}
