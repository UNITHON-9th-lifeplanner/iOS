//
//  QuestionVM.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import Foundation
import RxCocoa
import RxSwift

final class QuestionVM: BaseViewModel {
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

extension QuestionVM {}

// MARK: - Input

extension QuestionVM: Input {
    func bindInput() {}
}

// MARK: - Output

extension QuestionVM: Output {
    func bindOutput() {}
}
