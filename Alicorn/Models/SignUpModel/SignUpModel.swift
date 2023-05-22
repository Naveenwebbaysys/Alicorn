//
//  SignUpRequestModel.swift
//  Alicorn
//
//  Created by Mac on 15/05/23.
//

import Foundation

// MARK: - SignUpRequestModel
struct SignUpRequestModel: Encodable {
    let firstname, phone, phone2, email: String?
    let cwebsite, password, tmsSystem, joinAlicorn: String?
    let monthlyShipping, whichCompanyShipping: String?
    var isRquired : Bool?

    enum CodingKeys: String, CodingKey {
        case firstname, phone, phone2, email, cwebsite, password, isRquired
        case tmsSystem = "tms_system"
        case joinAlicorn = "join_alicorn"
        case monthlyShipping = "monthly_shipping"
        case whichCompanyShipping = "which_company_shipping"
        
    }
}


// MARK: - SignUpResponseModel
//   let signUpResponseModel = try? JSONDecoder().decode(SignUpResponseModel.self, from: jsonData)

struct SignUpResponseModel: Codable {
    let status: Int?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let user: User?
    let token: String?
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name, email: String?
}

