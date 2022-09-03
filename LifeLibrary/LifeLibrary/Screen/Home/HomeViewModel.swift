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
    var popularKeywords: PopularKeyword?
    
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
        let path = "life-goals/me?ageGroup=\(age_Group)"
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
    }
    
    func getPopularKeyword(age_Group: String, completion: ((PopularKeyword) -> Void)? = nil) {
        
        let path = "life-goals/popular?ageGroup=\(age_Group)"
        print("값 확인 \(path)")
        let resource = UrlResource<PopularKeyword>(path: path)
        
        apiSession.getRequest(with: resource)
            .subscribe(
                onNext: { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        print(data)
                        completion?(data)
                    }
                }, onError: { error in
                    print(error)
                }
            )
            .disposed(by: bag)
    }
}

// MARK: - Input

extension HomeViewModel: Input {
    func bindInput() {}
}

// MARK: - Output

extension HomeViewModel: Output {
    func bindOutput() {}
}

class PopularKeyword: Codable {
    var pastPopularKeywords: [String]
    var currentPopularKeywords: [String]
    var futurePopularKeywords: [String]
    
    enum CodingKeys: String, CodingKey {
        case pastPopularKeywords = "past_popular_keywords"
        case currentPopularKeywords = "current_popular_keywords"
        case futurePopularKeywords = "future_popular_keywords"
    }
}
