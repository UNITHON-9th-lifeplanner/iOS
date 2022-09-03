//
//  UserViewModel.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import Foundation
import RxCocoa
import RxSwift

final class UserViewModel: BaseViewModel {
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    var bag = DisposeBag()
    var input = Input()
    var output = Output()
    
    // MARK: - Input
    
    struct Input {}
    
    // MARK: - Output
    
    struct Output {}
    
    // MARK: - Init
    
    init() {
        bindInput()
        bindOutput()
    }
    
    deinit {
        bag = DisposeBag()
    }
}

// MARK: - Helpers

extension UserViewModel {
    
}

// MARK: - Input

extension UserViewModel: Input {
    func bindInput() {}
}

// MARK: - Output

extension UserViewModel: Output {
    func bindOutput() {}
}
