//
//  urlResource.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import Foundation

struct UrlResource<T: Decodable> {
    let baseURL = URL(string: "http://10.10.98.83:8080/")
    let path: String
    var resultURL: URL {
        return path.contains("http")
        ? URL(string: path)!
        : baseURL.flatMap { URL(string: $0.absoluteString + path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) }!
    }
    
    func judgeError(statusCode: Int) -> Result<T, APIError> {
        switch statusCode {
        case 400, 402...403, 405...408: return .failure(.decode(status: statusCode))
        case 401: return .failure(.unauthrized)
        case 404: return .failure(.notfound)
        case 409: return .failure(.conflict)
        case 500: return .failure(.http(status: statusCode))
        default: return .failure(.unknown(status: statusCode))
        }
    }
}
