//
//  RequestType.swift
//  Countries
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import Foundation

/// Enum which represent Request Type
enum RequestType {
    case counties
    case provenance(Int)
    case flag(String)
    
    var urlString: String {
        switch self {
        case .counties:
            return "https://connect.mindbodyonline.com/rest/worldregions/country"
        case .provenance(let id):
            return "https://connect.mindbodyonline.com/rest/worldregions/country/\(id)/province"
        case .flag(let code):
            return "https://www.countryflags.io/\(code)/flat/64.png"
        }
    }
}
