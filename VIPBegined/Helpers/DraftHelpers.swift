//
//  DraftHelpers.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/8/21.
//

import Foundation

final class DraftHelpers {
    static let shared = DraftHelpers()
}

extension DraftHelpers {

    func draftUsers() -> [UserModel] {
        return [
            UserModel(id: "01234567890", name: "Draft Durian"),
            UserModel(id: "1234567890", name: "Durian Draft")
        ]
    }
}
