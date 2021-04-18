//
//  EntriesRepository.swift
//  VIPBegined
//
//  Created by Nguyen Truong on 4/12/21.
//

import Foundation
import RxSwift

protocol EntriesRepositoryType: Repository {
    func getCountry() -> Observable<CountryModel>
}

class EntriesRepository: EntriesRepositoryType {

    func getCountry() -> Observable<CountryModel> {
        let input = CountryInput()
        return APIService.shared.getCountryInfo(input).map { output -> CountryModel in
            if let country = output.country {
                return country
            }
            throw APIResponseError.message("Country not found!")
        }
    }


}
