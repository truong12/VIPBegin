//
//  CountryEntity.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/18/21.
//

import Foundation

protocol CountryEntity {
    var name: String { get }
    var capital: CapitalModel { get }
    // Can more follow API Result
}
