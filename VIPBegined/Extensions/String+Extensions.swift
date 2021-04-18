//
//  String+Extensions.swift
//  VIPBegined
//
//  Created by Le Tuan on 2/3/21.
//

import Foundation
import UIKit

extension String {

    var isNotEmpty: Bool {
        return !isEmpty
    }

    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }

    var isNumber: Bool {
        return Double(self) != nil
    }

    var isNoNumber: Bool {
        return Double(self) == nil
    }

    func highlightString(_ keyword: String, font: UIFont) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let keywordRange = (self as NSString).range(of: keyword)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: keywordRange)
        return attributedString
    }

    func highlightString(_ keyword: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let keywordRange = (self as NSString).range(of: keyword)
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: keywordRange)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: keywordRange)
        return attributedString
    }
    
    func highlightString(_ keywords: [String], font: UIFont) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for keyword in keywords {
            let keywordRange = (self as NSString).range(of: keyword)
            attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: keywordRange)
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8.0
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value: paragraphStyle, range: (self as NSString).range(of: self))
        return attributedString
    }

    func toInt() -> Int {
        return Int(self) ?? 0
    }

    var doubleValue: Double {
        return Double(self) ?? 0.0
    }
}
