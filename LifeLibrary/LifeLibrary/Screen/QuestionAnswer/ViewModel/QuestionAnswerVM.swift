//
//  QuestionAnswerVM.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import Foundation
import RxCocoa
import RxSwift

final class QuestionAnswerVM: BaseViewModel {
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    var bag = DisposeBag()
    var input = Input()
    var output = Output()
    
    // MARK: - Input
    
    struct Input {
        var selectedDay = BehaviorRelay<Date>(value: Date.now)
        var moveMonth = PublishRelay<Int>()
    }
    
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

extension QuestionAnswerVM {
    func firstDayOfMonth(date: Date) -> Date? {
        return Calendar.current.date(
            from: Calendar.current.dateComponents(
                [.year, .month],
                from: Calendar.current.startOfDay(for: date)))
    }
}

// MARK: - Input

extension QuestionAnswerVM: Input {
    func bindInput() {
        input.moveMonth
            .subscribe(onNext: { [weak self] value in
                guard let self = self,
                      let selectedDate = Calendar.current.date(byAdding: .month,
                                                               value: value,
                                                               to: self.input.selectedDay.value),
                      let firstDayOfMonth = self.firstDayOfMonth(date: selectedDate)
                else { return }
                self.input.selectedDay.accept(firstDayOfMonth)
            })
            .disposed(by: bag)
    }
}

// MARK: - Output

extension QuestionAnswerVM: Output {
    func bindOutput() {}
}
