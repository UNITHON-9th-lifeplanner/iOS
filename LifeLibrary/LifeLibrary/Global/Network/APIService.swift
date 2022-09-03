//
//  APIService.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit
import Alamofire
import RxSwift

protocol APIService {
    func getRequest<T: Decodable>(with urlResource: UrlResource<T>) -> Observable<Result<T, APIError>>
    
    func postRequest<T: Decodable>(with urlResource: UrlResource<T>, param: Parameters?) -> Observable<Result<T, APIError>>
    
    func postRequestWithImage<T: Decodable>(with urlResource: UrlResource<T>, param: Parameters, image: UIImage, method: HTTPMethod) -> Observable<Result<T, APIError>>
    
    func putRequest<T: Decodable>(with urlResource: UrlResource<T>, param: Parameters?) -> Observable<Result<T, APIError>>
    
    func deleteRequest<T: Decodable>(with urlResource: UrlResource<T>) -> Observable<Result<T, APIError>>
}
