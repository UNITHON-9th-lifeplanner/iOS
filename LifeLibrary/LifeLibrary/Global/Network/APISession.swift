//
//  APISession.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit
import Alamofire
import RxSwift

struct APISession: APIService {
    func getRequest<T>(with urlResource: UrlResource<T>) -> Observable<Result<T, APIError>> where T: Decodable {
        
        Observable<Result<T, APIError>>.create { observer in
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "Authorization": "Bearer " + (UserInfo.shared.accessToken ?? "")
            ]
            
            print(headers)
            
            let task = AF.request(urlResource.resultURL,
                                  encoding: URLEncoding.default,
                                  headers: headers)
                .validate(statusCode: 200...399)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .failure:
                        observer.onNext(urlResource.judgeError(statusCode: response.response?.statusCode ?? -1))
                        
                    case .success(let data):
                        observer.onNext(.success(data))
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func postRequest<T: Decodable>(with urlResource: UrlResource<T>, param: Parameters?) -> Observable<Result<T, APIError>> {
        
        Observable<Result<T, APIError>>.create { observer in
            var headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            if let accessToken = UserDefaults.standard.string(forKey: "access_token"), !accessToken.isEmpty {
                headers["Authorization"] = "Bearer " + accessToken
            }
            
            let task = AF.request(urlResource.resultURL,
                                  method: .post,
                                  parameters: param,
                                  encoding: JSONEncoding.default,
                                  headers: headers)
                .validate(statusCode: 200...399)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .failure:
                        observer.onNext(urlResource.judgeError(statusCode: response.response?.statusCode ?? -1))
                        
                    case .success(let data):
                        observer.onNext(.success(data))
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func postRequestWithImage<T: Decodable>(with urlResource: UrlResource<T>, param: Parameters, image: UIImage, method: HTTPMethod) -> Observable<Result<T, APIError>> {
        Observable<Result<T, APIError>>.create { observer in
            let headers: HTTPHeaders = [
                "Content-Type": "multipart/form-data"
            ]
            
            let task = AF.upload(multipartFormData: { (multipart) in
                for (key, value) in param {
                    multipart.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
                }
                if let imageData = image.jpegData(compressionQuality: 1) {
                    multipart.append(imageData, withName: "files", fileName: "image.png", mimeType: "image/png")
                }
            }, to: urlResource.resultURL, method: method, headers: headers)
                .validate(statusCode: 200...399)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .failure:
                        observer.onNext(urlResource.judgeError(statusCode: response.response?.statusCode ?? -1))
                        
                    case .success(let data):
                        observer.onNext(.success(data))
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func putRequest<T>(with urlResource: UrlResource<T>, param: Parameters?) -> Observable<Result<T, APIError>> where T: Decodable {
        Observable<Result<T, APIError>>.create { observer in
            var headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            if let accessToken = UserDefaults.standard.string(forKey: "access_token"), !accessToken.isEmpty {
                headers["Authorization"] = "Bearer " + accessToken
            }
            
            let task = AF.request(urlResource.resultURL,
                                  method: .put,
                                  parameters: param,
                                  encoding: JSONEncoding.default,
                                  headers: headers)
                .validate(statusCode: 200...399)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .failure:
                        observer.onNext(urlResource.judgeError(statusCode: response.response?.statusCode ?? -1))
                        
                    case .success(let data):
                        observer.onNext(.success(data))
                    }
                }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
