//
//  CountryModel.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/18/21.
//

import Foundation
import ObjectMapper

struct CountryModel: CountryEntity {

    var name: String
    var capital: CapitalModel

    init() {
        self.name = ""
        self.capital = CapitalModel()
    }
}

// MARK: - Mappable
extension CountryModel: Mappable {

    init?(map: Map) {
        self.init()
    }

    mutating func mapping(map: Map) {
        name <- map["Name"]
        capital <- map["Capital"]
    }
}
