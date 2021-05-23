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
    
    func fetchProvenances(for countryId: Int, completion: @escaping () -> Void) {
        APIService(with: urlSessionService).fetchProvenance(for: countryId) { [weak self] provenances in
            guard let result = provenances.result else { return }
            self?.provenances = result
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    
}
