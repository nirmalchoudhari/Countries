//
//  ProvenanceViewModel.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

final class ProvenanceViewModel {
    
    private(set) lazy var provenances = [Provenance]()
    private lazy var urlSessionService = URLSessionService()
    var country: Country?
    
    var noProvenance: Bool {
        return provenances.isEmpty
    }
    
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
    
    func numberOfRows() -> Int {
        return provenances.count
    }
    
    func getProvenance(_ index: Int) -> Provenance? {
        guard provenances.count > index else { return nil }
        return provenances[index]
    }
    
}
