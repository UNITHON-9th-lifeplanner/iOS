//
//  OthersAnswersVC.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit
import RxCocoa
import RxGesture
import RxSwift
import SnapKit
import Then

class OthersAnswersVC: BaseViewController {
    private let baseScrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let questionLabel = UILabel()
        .then {
            $0.text = "ASDFASDFASDFASDFASDFASDFASDFSA"
            $0.font = .title1
            $0.textColor = .label
            $0.setLineBreakMode()
        }
    
    private let answersTV = UITableView()
        .then {
            $0.separatorStyle = .none
        }
    
    private let naviBar = NavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureNaviBar()
        configureContentView()
        configureAnswersTV()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
    override func bindInput() {
        super.bindInput()
    }
    
    override func bindOutput() {
        super.bindOutput()
    }
    
}

// MARK: - Helpers

extension OthersAnswersVC {
    
}

// MARK: - Configure

extension OthersAnswersVC {
    private func configureContentView() {
        view.addSubview(baseScrollView)
        baseScrollView.addSubview(contentView)
        contentView.addSubviews([questionLabel,
                                 answersTV])
    }
    
    private func configureNaviBar() {
        naviBar.naviType = .push
        naviBar.configureNaviBar(targetVC: self, title: nil)
        naviBar.configureBackBtn(targetVC: self)
    }
    
    private func configureAnswersTV() {
        
    }
}

// MARK: - Layout

extension OthersAnswersVC {
    private func configureLayout() {
        baseScrollView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(76)
        }
        
        answersTV.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - Input

extension OthersAnswersVC {
    
}

// MARK: - Output

extension OthersAnswersVC {
    
}
