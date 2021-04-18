//
//  SettingCell.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/9/21.
//

import UIKit

class SettingCell: BaseTableCell {

    @IBOutlet fileprivate weak var titleLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var valueLabel: BaseRegularLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func display(with title: String, and value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
    
}
