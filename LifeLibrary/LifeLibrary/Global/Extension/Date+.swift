//
//  Date+.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import Foundation

extension Date {
    func toString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
}
