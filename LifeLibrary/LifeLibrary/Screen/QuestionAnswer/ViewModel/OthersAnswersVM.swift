//
//  OthersAnswersVM.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/04.
//

import Foundation
import RxCocoa
import RxSwift

final class OthersAnswersVM: BaseViewModel {
    var apiSession: APIService = APISession()
    let apiError = PublishSubject<APIError>()
    var bag = DisposeBag()
    var input = Input()
    var output = Output()
    
    // MARK: - Input
    
    struct Input {}
    
    // MARK: - Output
    
    struct Output {
        var question: PublishRelay<String> = PublishRelay()
        var answerList: BehaviorRelay<[Answer]> = BehaviorRelay(value: [])
        var dataSource: Observable<[OthersAnswersDataSource]> {
            answerList
                .map {
                    [OthersAnswersDataSource(section: .zero, items: $0)]
                }
        }
    }
    
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

extension OthersAnswersVM {}

// MARK: - Input

extension OthersAnswersVM: Input {
    func bindInput() {}
}

// MARK: - Output

extension OthersAnswersVM: Output {
    func bindOutput() {}
}

// MARK: - Networking

extension OthersAnswersVM {
    func getProceedingChallengeList(questionID: Int) {
        let path = "questions/\(questionID)"
        let resource = UrlResource<OthersAnswersResponseModel>(path: path)
        
        apiSession.getRequest(with: resource)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .failure(let error):
                    owner.apiError.onNext(error)
                case .success(let data):
                    owner.output.question.accept(data.question)
                    owner.output.answerList.accept(data.answers)
                }
            })
            .disposed(by: bag)
    }
}
