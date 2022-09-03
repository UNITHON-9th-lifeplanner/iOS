//
//  String+.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
