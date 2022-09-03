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
    var keywords: [String] = []
    
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
    func getMyPlan(age_Group: String, completion: ((String) -> Void)? = nil) {
        let path = "life-goals/popular?ageGroup=\(age_Group)"
        print("값 확인 \(path)")
        let resource = UrlResource<LifePlanner>(path: path)
        
        apiSession.getRequest(with: resource)
            .subscribe(
                onNext: { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        print(data)
                        self.keywords = data.popularKeywords
                        completion?(data.lifeGoalContent ?? "")
                    }
                }, onError: { error in
                    print(error)
                }
            )
            .disposed(by: bag)
    }}

// MARK: - Input

extension HomeViewModel: Input {
    func bindInput() {}
}

// MARK: - Output

extension HomeViewModel: Output {
    func bindOutput() {}
}