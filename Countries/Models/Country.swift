//
//  Country.swift
//  Countries
//
//  Created by Nirmal Choudhari on 22/05/21.
//

import Foundation

struct Country: Codable {
    var id: Int
    var phoneCode: String?
    var code: String
    var name: String
    
    init(id: Int, phoneCode: String?, code: String, name: String) {
        self.id = id
        self.phoneCode = phoneCode
        self.code = code
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case phoneCode = "PhoneCode"
        case code = "Code"
        case name = "Name"
    }
}
