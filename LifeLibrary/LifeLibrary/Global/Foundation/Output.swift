//
//  Output.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import Foundation

protocol Output {
    associatedtype Output
    
    var output: Output { get }
    
    func bindOutput()
}
