//
//  LoginModel.swift
//  Alicorn
//
//  Created by Mac on 18/05/23.
//

import Foundation

struct LoginRequestModel: Codable {
    
    let email : String?
    let password : String?
}

//   let loginResponseModel = try? JSONDecoder().decode(LoginResponseModel.self, from: jsonData)
// MARK: - LoginResponseModel


struct LoginResponseModel: Codable {
    let status: Int?
    let message: String?
    let data: LoginDataClass?
}

// MARK: - DataClass
struct LoginDataClass: Codable {
    let user: LoginUser?
    let token: String?
}

// MARK: - User
struct LoginUser: Codable {
    let id: Int?
    let name, email: String?
}
