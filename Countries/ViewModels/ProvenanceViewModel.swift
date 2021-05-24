//
//  ProvenanceViewModel.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

final class ProvenanceViewModel {
    
    private(set) lazy var provenances = [Provenance]()
    var country: Country?
    private let urlSessionService: NetworkService
    
    /// Initializer
    /// - Parameter networkService: A Network service implementation
    init(networkService: NetworkService = URLSessionService()) {
        urlSessionService = networkService
    }
    
    /// Checks if any provenance is aailable or not
    var noProvenance: Bool {
        return provenances.isEmpty
    }
    
    /// Fetch Provenance from API
    /// - Parameters:
    ///   - countryId: Country for which Provienance requested
    ///   - completion: completion handler with list of provenance and error description if any
    func fetchProvenances(for countryId: Int, completion: @escaping ([Provenance]?, ErrorDescription?) -> Void) {
        APIService(with: urlSessionService).fetchProvenance(for: countryId) { [weak self] response in
            switch response {
            case .result(let provenances):
                self?.provenances = provenances
                completion(provenances, nil)
            case .error(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    /// Return the number of rows for Provenance TableView
    /// - Returns: number of provenances
    func numberOfRows() -> Int {
        return provenances.count
    }
    
    /// Returns a Provenance object for given index
    /// - Parameter index: index for selected item
    /// - Returns: Provenance at given index
    func getProvenance(_ index: Int) -> Provenance? {
        guard provenances.count > index else { return nil }
        return provenances[index]
    }
    
}
