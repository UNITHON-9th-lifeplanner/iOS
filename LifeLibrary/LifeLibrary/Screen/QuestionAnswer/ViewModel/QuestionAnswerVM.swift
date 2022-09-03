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
    
    func isToday(_ date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date) == dateFormatter.string(from: Date.now)
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

// MARK: - Networking

extension QuestionAnswerVM {
    func getQuestion(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let path = "questions?date=\(dateFormatter.string(from: date))"
        let resource = UrlResource<QuestionResponseModel>(path: path)
        
        apiSession.getRequest(with: resource)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                dump(result)
                switch result {
                case .failure(let error):
                    owner.apiError.onNext(error)
                case .success(let data):
                    dump(data)
                }
            })
            .disposed(by: bag)
    }
}
