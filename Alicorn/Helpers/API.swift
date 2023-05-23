//
//  API.swift
//  Alicorn
//
//  Created by Mac on 16/05/23.
//

import Foundation
import Alamofire


var authToken = ""
var headers : HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer " + authToken]
let baseURL = "https://beta.alicorns.com/api/"
let signUpAPI = "register"
let loginAPI = "login"
let userInfo = "user"
let productAPI = "product"
let deleteProductAPI = "product/"
