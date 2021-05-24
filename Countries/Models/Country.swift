//
//  Country.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

/// Model for Country
struct Country: Codable {
    var id: Int
    var phoneCode: String?
    var code: String
    var name: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case phoneCode = "PhoneCode"
        case code = "Code"
        case name = "Name"
    }
}
