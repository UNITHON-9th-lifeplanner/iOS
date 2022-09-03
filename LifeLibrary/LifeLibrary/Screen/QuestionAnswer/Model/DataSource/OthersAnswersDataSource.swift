//
//  OthersAnswersDataSource.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/04.
//

import Foundation
import RxDataSources

struct OthersAnswersDataSource {
    var section: Int
    var items: [Item]
}

extension OthersAnswersDataSource: SectionModelType {
    typealias Item = Answer
    
    init(original: OthersAnswersDataSource, items: [Item]) {
        self = original
        self.items = items
    }
}
