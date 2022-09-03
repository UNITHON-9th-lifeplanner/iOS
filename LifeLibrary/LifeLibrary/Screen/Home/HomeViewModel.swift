//
//  HomeViewModel.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/04.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay

final class HomeViewModel: BaseViewModel {
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

// MARK: - Networking
extension HomeViewModel {
    
}

// MARK: - Input

extension HomeViewModel: Input {
    func bindInput() {}
}

// MARK: - Output

extension HomeViewModel: Output {
    func bindOutput() {}
}
