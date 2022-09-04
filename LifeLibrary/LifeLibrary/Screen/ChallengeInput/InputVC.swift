//
//  InputVC.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/04.
//

import UIKit
import RxCocoa
import RxGesture
import RxSwift
import SnapKit
import Then

class InputVC: BaseViewController {
    private let naviBar = NavigationBar()
    
    private let progressStackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.alignment = .fill
        }
    
    private let baseScrollView = UIScrollView()
        .then {
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
        }
    
    private let view1 = ChallengeInputVC()
        .then {
            $0.setQuestions("10대의 ‘나’를 되돌아본다면?")
            $0.setAnswers("대덕마이스터고에 하지 않아서 후회된다.")
        }
    
    private let view2 = ChallengeInputVC()
        .then {
            $0.setQuestions("20대의 ‘나’를 되돌아본다면?")
            $0.setAnswers("재밌는 대학생활을 보내지 못한 거 같다..")
        }
    
    private let view3 = ChallengeInputVC()
        .then {
            $0.setQuestions("30대의 ‘나’를 되돌아본다면?")
            $0.setAnswers("유럽여행을 가야지~")
        }
    
    private let view4 = ChallengeInputVC()
        .then {
            $0.setQuestions("40대의 ‘나’를 되돌아본다면?")
            $0.setAnswers("파이어족이 돼서 돈 걱정 없이 살고 싶당 ㅎㅎ")
        }
    
    private let view5 = ChallengeInputVC()
        .then {
            $0.setQuestions("50대의 ‘나’를 되돌아본다면?")
            $0.setAnswers("책을 많이 읽는 성장한 어른이 되고 싶다.")
        }
    
    private let view6 = ChallengeInputVC()
        .then {
            $0.setQuestions("60대 이후 노년기의 ‘나’의 목표는?")
            $0.setAnswers("나이가 들어서도 끊임없이 배우고 싶다.")
        }
    
    private let challengeInputStackView = UIStackView()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        naviBar.naviType = .present
        naviBar.configureNaviBar(targetVC: self, title: nil)
        naviBar.configureBackBtn(targetVC: self)
        naviBar.configureRightBarBtn(targetVC: self, image: UIImage(systemName: "chevron.right")!)
        
        view.addSubviews([progressStackView,
                         baseScrollView])
        
        let views = [view1.view!, view2.view!, view3.view!, view4.view!, view5.view!, view6.view!]
        
        let stackView = UIStackView(arrangedSubviews: views)
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        baseScrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.centerY.equalToSuperview()
            $0.width.equalTo(screenWidth * 6)
        }
        
        views.forEach {
            configureLayout($0)
        }
        baseScrollView.addSubview(stackView)
        
        for _ in 0..<6 {
            let view = UIView()
            view.backgroundColor = .orange100
            progressStackView.addArrangedSubview(view)
        }
    }
    
    override func layoutView() {
        super.layoutView()
        layoutViews()
    }
    
    override func bindInput() {
        super.bindInput()
        naviBar.rightBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.dismiss(animated: true)
            })
            .disposed(by: bag)
    }
    
    override func bindOutput() {
        super.bindOutput()
    }
    
}

// MARK: - Helpers

extension InputVC {

}

// MARK: - Configure

extension InputVC {
    
}

// MARK: - Layout

extension InputVC {
    private func layoutViews() {
        baseScrollView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureLayout(_ view: UIView) {
        view.snp.makeConstraints {
            $0.width.equalTo(baseScrollView.snp.width)
            $0.height.equalTo(baseScrollView.snp.height)
        }
    }
}

// MARK: - Dependency

extension InputVC {
    
}

// MARK: - Input

extension InputVC {
    
}

// MARK: - Output

extension InputVC {
    
}
