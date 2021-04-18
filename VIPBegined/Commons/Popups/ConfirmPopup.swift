//
//  ConfirmPopup.swift
//  Reward
//
//  Created by Le Tuan on 26/2/21.
//  Copyright © 2021 Nguyen Truong. All rights reserved.
//

import UIKit

class ConfirmPopup: BaseViewController {
    
    @IBOutlet fileprivate weak var titleLabel: BaseBoldLabel!
    @IBOutlet fileprivate weak var messageLabel: BaseRegularLabel!
    @IBOutlet fileprivate weak var confirmButton: BaseBorderButton!
    @IBOutlet fileprivate weak var closeButton: BaseBorderButton!

    var popupTitle = ""
    var popupMessage = ""
    var didConfirm: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigation()
    }
    
    override func performLocalizeTexts() {
        titleLabel.text = popupTitle
        messageLabel.text = popupMessage
        confirmButton.setTitle("button.confirm".localized, for: .normal)
        closeButton.setTitle("button.close".localized, for: .normal)
    }
}

// MARK: - Actions
extension ConfirmPopup {
    @IBAction fileprivate func confirmAction(_ sender: Any) {
        removeWithAnimate { [weak self] (_) in
            guard let this = self else { return }
            this.didConfirm?()
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
         removeWithAnimate()
     }
}
