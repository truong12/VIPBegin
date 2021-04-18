//
//  BaseTableCell.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/9/21.
//

import UIKit

class BaseTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        performLocalizeTexts()
    }

    override func prepareForReuse() {
        performLocalizeTexts()
    }

    func performLocalizeTexts() {

    }
}
