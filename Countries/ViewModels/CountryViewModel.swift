//
//  CountryViewModel.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

typealias ErrorDescription = String

/// View model for country view
final class CountryViewModel {
    
    private(set) lazy var countries = [Country]()
    private lazy var filteredCountries = [Country]()
    
    private let urlSessionService:NetworkService
    
    /// Initializer
    /// - Parameter networkService: A Network service implementation
    init(networkService: NetworkService = URLSessionService()) {
        urlSessionService = networkService
    }

    
    /// Requests countries from countries API
    /// - Parameter completion: Completion handler whic return the error description and a list of country
    func fetchCountries(_ completion: @escaping ([Country]?, ErrorDescription?) -> Void) {
        APIService(with: urlSessionService).fetchCountries { [weak self] response in
            switch response {
            case .result(let countries):
                self?.countries = countries
                completion(countries, nil)
            case .error(let e):
                completion(nil, e.errorDescription)
            }
        }
    }
    
    /// Filters the county list based on the search string. Checks if any country starts with the provided string
    /// - Parameter searchText: a string as search query
    func filterCountries(_ searchText: String) {
        filteredCountries = countries.filter{$0.name.lowercased().starts(with: searchText.lowercased())}
    }
    
    /// Return the number of rows for Country TableView
    /// - Parameter mode: mode of the list either complete list or filtered list
    /// - Returns: number of countries
    func numberOfRows(_ mode: CountryListMode) -> Int {
        switch mode {
        case .complete:
            return countries.count
        case .filtered:
            return filteredCountries.count
        }
    }
    
    /// Returns the
    /// - Parameters:
    ///   - index: index for the selected item
    ///   - mode: mode of the list either complete list or filtered list
    /// - Returns: Country object at given index
    func getCountry(_ index: Int, mode: CountryListMode) -> Country? {
        guard countries.count > index else { return nil }
        switch mode {
        case .complete:
            return countries[index]
        case .filtered:
            return filteredCountries[index]
        }
    }
}
