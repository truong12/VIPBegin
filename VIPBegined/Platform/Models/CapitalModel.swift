//
//  CapitalModel.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/18/21.
//

import Foundation
import ObjectMapper

struct CapitalModel: CapitalEntity {
    var name: String

    init() {
        self.name = ""
    }
}

// MARK: - Mappable
extension CapitalModel: Mappable {

    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        name <- map["Name"]
    }
}
