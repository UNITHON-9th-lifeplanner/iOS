//
//  Input.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import Foundation

protocol Input {
    associatedtype Input
    
    var input: Input { get }
    
    func bindInput()
}
