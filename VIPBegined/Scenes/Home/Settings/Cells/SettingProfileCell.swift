//
//  SettingProfileCell.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/9/21.
//

import UIKit

class SettingProfileCell: BaseTableCell {

    @IBOutlet fileprivate weak var profileLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var nameLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var mobileLabel: BaseRegularLabel!

    @IBOutlet fileprivate weak var nameValueLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var mobileValueLabel: BaseRegularLabel!

    var user: UserModel? {
        didSet {
            guard let user = self.user else { return }
            nameValueLabel.text = user.name
            mobileValueLabel.text = user.id
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func performLocalizeTexts() {
        profileLabel.text = "setting.profile".localized
        nameLabel.text = "setting.name".localized
        mobileLabel.text = "setting.mobile.number".localized
    }
    
}
