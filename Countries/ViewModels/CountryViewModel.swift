//
//  CountryViewModel.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

final class CountryViewModel {
    
    private(set) lazy var countries = [Country]()
    private lazy var filteredCountries = [Country]()
    
    private lazy var urlSessionService = URLSessionService()

    func fetchCountries(_ completion: @escaping () -> Void) {
        APIService(with: urlSessionService).fetchCountries { [weak self] countries in
            guard let result = countries.result else { return }
            self?.countries = result
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func filterCountries(_ searchText: String) {
        filteredCountries = countries.filter{$0.name.lowercased().starts(with: searchText.lowercased())}
    }
    
    func numberOfRows(_ mode: CountryListMode) -> Int {
        switch mode {
        case .complete:
            return countries.count
        case .filtered:
            return filteredCountries.count
        }
    }
    
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
