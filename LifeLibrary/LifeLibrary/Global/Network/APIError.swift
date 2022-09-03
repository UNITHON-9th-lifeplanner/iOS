//
//  APIError.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import Foundation

enum APIError: Error {
    case decode(status: Int)
    case http(status: Int)
    case unknown(status: Int)
    case conflict
    case unauthrized
    case notfound
}

extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case let .decode(status):
            return "Decode Error: \(status)"
        case let .http(status):
            return "HTTP Error: \(status)"
        case let .unknown(status):
            return "Unknown Error: \(status)"
        case .conflict:
            return "ID Conflict"
        case .unauthrized:
            return "잘못된 정보가 입력됨"
        case .notfound:
            return "입력한 정보를 찾을 수 없음."
        }
    }
}
