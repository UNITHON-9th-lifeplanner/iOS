//
//  SplachViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import Foundation
import RxSwift
import RxRelay
import UIKit
import SwifterSwift

class SplashViewController: BaseViewController {
    let loginAccessTokenRx = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLogin()
        
        let minExposeTime = Observable<Int>.timer(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
        let maxExposeTime = Observable<Int>.timer(RxTimeInterval.seconds(3), scheduler: MainScheduler.instance)
        
        minExposeTime
            .flatMap({ [weak self] _ in
                self?.loginAccessTokenRx ?? BehaviorRelay<String>(value: "")
            })
            .compactMap({ $0 })
            .distinctUntilChanged()
            .take(until: maxExposeTime)
            .subscribe(onNext: { [weak self] accessToken in
                // 최소노출시간 대기 후 로그인여부가 확인되면 화면 진입
                accessToken == "" ? self?.presentOnboardingView() : self?.presentHomeView()
            }, onCompleted: { [weak self] in
                // 최대노출시간을 초과한 후에도 현재 화면이 노출 중이면 다음 화면으로 강제 이동
                guard self?.isVisible == true else { return }
                
                self?.presentOnboardingView()
            }).disposed(by: disposeBag)
    }
}

extension SplashViewController {
    func checkLogin() {
        let accessToken = UserDefaults.standard.string(forKey: "access_token") ?? ""
        
        loginAccessTokenRx.accept(accessToken)
    }
    
    func presentOnboardingView() {
        let vc = OnboardingNavigationVC()
        
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: false, completion: nil)
    }
    
    func presentHomeView() {
        let vc = HomeViewController()
        
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true)
    }
}
