//
//  LoginModel.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/04.
//

import Foundation

class LoginModel: Codable {
    let age: Int
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case age
        case accessToken = "access_token"
    }
}
