//
//  CountryViewModel.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

final class CountryViewModel {
    
    private(set) lazy var countries = [Country]()
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
    
    func numberOfRows() -> Int {
        return countries.count
    }
    
    func getCountry(_ index: Int) -> Country? {
        guard countries.count > index else { return nil }
        return countries[index]
    }
}
