//
//  Provenance.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

struct Provenance: Codable {
    var id: Int
    var countryCode: String
    var code: String
    var name: String
    
    init(id: Int, countryCode: String, code: String, name: String) {
        self.id = id
        self.countryCode = countryCode
        self.code = code
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case countryCode = "CountryCode"
        case code = "Code"
        case name = "Name"
    }
}
