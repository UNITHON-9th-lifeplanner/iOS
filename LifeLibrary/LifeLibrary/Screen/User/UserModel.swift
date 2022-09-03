//
//  UserModel.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import Foundation
import UIKit

class UserModel: NSObject, Codable {
    var id: String
    var name: String
    var age: Int
    var accessToken: String
}
