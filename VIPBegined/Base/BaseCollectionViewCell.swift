//
//  BaseCollectionViewCell.swift
//  VIPBegined
//
//  Created by Le Tuan on 1/3/21.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        performLocalizedTexts()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        performLocalizedTexts()
    }
    
    func performLocalizedTexts() {
        
    }
}
