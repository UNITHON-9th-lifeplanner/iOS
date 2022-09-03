//
//  UserModel.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import Foundation
import SwiftyJSON

class UserModel: NSObject, Codable {
    var email: String
    var name: String
    var age: Int
    var accessToken: String
    
    init(email: String, name: String, age: Int, accessToken: String) {
        self.email = email
        self.name = name
        self.age = age
        self.accessToken = accessToken
    }
    
    convenience init?(json: JSON) {
        guard let email = json["email"].string,
              let name = json["name"].string,
              let age = json["age"].int,
              let accessToken = json["accessToken"].string else { return nil }
        
        self.init(email: email, name: name, age: age, accessToken: accessToken)
    }
}
