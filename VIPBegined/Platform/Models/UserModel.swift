//
//  UserModel.swift
//  VIPBegined
//
//  Created by Le Tuan on 2/3/21.
//

import Foundation
import ObjectMapper

struct UserModel: UserEntity {
    
    var id: String
    var name: String
    
    init() {
        self.id = ""
        self.name = ""
    }

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: - Mappable
extension UserModel: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

// MARK: - Codable
extension UserModel: Codable {
    enum Key: String, CodingKey {
        case id, name, centre
    }

    init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: Key.self)
        if let id = try? container.decode(String.self, forKey: Key.id) {
            self.id = id
        }
        if let name = try? container.decode(String.self, forKey: Key.name) {
            self.name = name
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode(id, forKey: Key.id)
        try container.encode(name, forKey: Key.name)
    }
}

extension UserModel {
    var welcome: String {
        return String(format: "scanner.welcome".localized, name)
    }
}
