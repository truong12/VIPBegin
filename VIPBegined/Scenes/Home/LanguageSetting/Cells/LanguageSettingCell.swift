//
//  LanguageSettingCell.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/14/21.
//

import UIKit

class LanguageSettingCell: BaseTableCell {

    @IBOutlet fileprivate weak var languageLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var checkIcon: UIImageView!

    var language: DurianLanguage? {
        didSet {
            guard let language = self.language else { return }
            languageLabel.text = language.description
            if language.localizedValue == AppStatusManager.shared.localeIdentifier {
                checkIcon.show()
            } else {
                checkIcon.hidden()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
