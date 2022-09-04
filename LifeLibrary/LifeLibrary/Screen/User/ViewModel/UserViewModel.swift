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
extension UserViewModel {
    func postLoginAction(account_id: String, password: String, completion: ((String) -> Void)? = nil) {
        let path = "login"
        let resource = UrlResource<LoginModel>(path: path)
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
                            completion?("비밀번호가 잘못되었습니다.")
                        case .notfound:
                            completion?("아이디를 찾을 수 없습니다. ")
                        default :
                            print(error)
                        }
                    case .success(let data):
                        print(data)
                        UserInfo.shared.age = data.age
                        UserInfo.shared.accessToken = data.accessToken
                        UserDefaults.standard.set(data.age, forKey: "age")
                        UserDefaults.standard.set(data.accessToken, forKey: "access_token")
                        completion?("")
                    }
                }, onError: { error in
                    print(error)
                }
            )
            .disposed(by: bag)
    }
    
    func postSignUpAction(account_id: String, password: String, name: String, birthday: String, completion: (() -> Void)? = nil) {
        let path = "users"
        let resource = UrlResource<LoginModel>(path: path)
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
                    case .success(let data):
                        print(data.accessToken)
                        UserInfo.shared.age = data.age
                        UserInfo.shared.accessToken = data.accessToken
                        UserDefaults.standard.set(data.age, forKey: "age")
                        UserDefaults.standard.set(data.accessToken, forKey: "access_token")
                        completion?()
                    }
                }, onError: { error in
                    print(error)
                }
            )
            .disposed(by: bag)
    }
    
    func postValidId(account_id: String, completion: ((Bool) -> Void)? = nil) {
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
                        completion?(false)
                    case .success(let validCheck):
                        print(validCheck)
                        completion?(validCheck["is_exists"] ?? true)
                    }
                }, onError: { error in
                    print(error)
                    completion?(false)
                }
            )
            .disposed(by: bag)
    }
    
    func putUserInfo(password: String, name: String, birthday: String) {
        let path = "users"
        let resource = UrlResource<Bool>(path: path)
        let param: [String: Any] = [
            "password": password,
            "name": name,
            "birthday": birthday
        ]
        
        apiSession.putRequest(with: resource, param: param)
            .subscribe(
                onNext: { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let check):
                        print(check)
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

extension UserViewModel {
    func dateTransForm(_ date: Date?) -> String? {
        return date?.string(withFormat: "yyyy-MM-dd")
    }
}
