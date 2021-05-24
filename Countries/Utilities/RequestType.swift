//
//  RequestType.swift
//  Countries
//
//  Created by Nirmal Choudhari on 24/05/21.
//

import Foundation

enum RequestType {
    case counties
    case provenance(Int)
    
    var urlString: String {
        switch self {
        case .counties:
            return "https://connect.mindbodyonline.com/rest/worldregions/country"
        case .provenance(let id):
            return "https://connect.mindbodyonline.com/rest/worldregions/country/" + String(id) + "/province"
        }
    }
}
