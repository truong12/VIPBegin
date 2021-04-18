//
//  API_Country.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/18/21.
//

import Foundation
import RxSwift
import ObjectMapper

extension APIService {

    func getCountryInfo(_ input: CountryInput) -> Observable<CountryOutput> {
        return request(input)
    }
}

class CountryInput: APIBaseInput {

    init() {
        super.init(urlString: APIURL.country, method: .get, parameters: nil)
    }
}

class CountryOutput: APIBaseOutput {

    var country: CountryModel?

    override func mapping(map: Map) {
        super.mapping(map: map)
        country <- map["Results"]
    }
}
