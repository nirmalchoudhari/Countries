//
//  Provenance.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

/// Model for Provenance
struct Provenance: Codable {
    var id: Int
    var countryCode: String
    var code: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case countryCode = "CountryCode"
        case code = "Code"
        case name = "Name"
    }
}
