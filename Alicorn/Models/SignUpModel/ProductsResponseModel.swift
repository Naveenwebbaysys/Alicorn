//
//  ProductsResponseModel.swift
//  Alicorn
//
//  Created by Mac on 23/05/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productsResponseModel = try? JSONDecoder().decode(ProductsResponseModel.self, from: jsonData)

import Foundation

// MARK: - ProductsResponseModel
struct ProductsResponseModel: Codable {
    let status: Int?
    let message: String?
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let productDescription: String?
    let nmfc, sub, datumClass, packageType: Int?
    let length, width, height: Int?
    let weight: String?
    let stackable, hazMat, un, unNumber: Int?
    let hazardClass: JSONNull?
    let packingType, quantity: Int?
    let palletID, userID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case productDescription = "product_description"
        case nmfc, sub
        case datumClass = "class"
        case packageType = "package_type"
        case length, width, height, weight, stackable
        case hazMat = "haz_mat"
        case un
        case unNumber = "un_number"
        case hazardClass = "hazard_class"
        case packingType = "packing_type"
        case quantity
        case palletID = "pallet_id"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

