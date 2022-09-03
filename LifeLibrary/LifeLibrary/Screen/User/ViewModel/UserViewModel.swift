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

// MARK: - Networking
extension UserViewModel {
    func postLoginAction(account_id: String, password: String) {
        let path = "login"
        let resource = UrlResource<[String: String]>(path: path)
        let param: [String: Any] = [
            "account_id": account_id,
            "password": password
        ]
        
        apiSession.postRequest(with: resource, param: param)
            .subscribe(
                onNext: { result in
                    switch result {
                    case .failure(let error):
                        switch error {
                        case .unauthrized:
                            print("\(error) 비밀번호가 잘못됨")
                        case .notfound:
                            print("\(error) \n 아이디를 찾을 수 없음.")
                        default :
                            print(error)
                        }
                    case .success(let accessToken):
                        print(accessToken)
                        UserDefaults.standard.set(accessToken["access_token"], forKey: "access_token")
                    }
                }, onError: { error in
                    print(error)
                }
            )
            .disposed(by: bag)
    }
    
    func postSignUpAction(account_id: String, password: String, name: String, birthday: String) {
        let path = "users"
        let resource = UrlResource<[String: String]>(path: path)
        let param: [String: Any] = [
            "account_id": account_id,
            "password": password,
            "name": name,
            "birthday": birthday
        ]
        
        apiSession.postRequest(with: resource, param: param)
            .subscribe(
                onNext: { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let accessToken):
                        print(accessToken)
                        UserDefaults.standard.set(accessToken["access_token"], forKey: "access_token")
                    }
                }, onError: { error in
                    print(error)
                }
            )
            .disposed(by: bag)
    }
    
    func postValidId(account_id: String, completion: ((Bool?) -> Void)? = nil) {
        let path = "users/account"
        let resource = UrlResource<[String: Bool]>(path: path)
        let param: [String: Any] = [
            "account_id": account_id
        ]
        
        apiSession.postRequest(with: resource, param: param)
            .subscribe(
                onNext: { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let validCheck):
                        print(validCheck)
                        completion?(validCheck["is_exists"])
                    }
                }, onError: { error in
                    print(error)
                }
            )
            .disposed(by: bag)
    }
}

// MARK: - Input

extension UserViewModel: Input {
    func bindInput() {}
}

// MARK: - Output

extension UserViewModel: Output {
    func bindOutput() {}
}
