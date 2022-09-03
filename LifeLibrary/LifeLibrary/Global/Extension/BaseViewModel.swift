//
//  BaseViewModel.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import Foundation
import RxSwift

protocol BaseViewModel: Input, Output {
    var apiSession: APIService { get }
    
    var bag: DisposeBag { get }
}
