//
//  QuestionView.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit
import SnapKit
import Then

class QuestionView: BaseView {
    private let questionLabel = UILabel()
        .then {
            $0.text = "오늘의 질문"
            $0.font = .body2
            $0.textColor = .orange100
            $0.setLineBreakMode()
        }
    
    private let editBtn = UIButton()
    
    override func configureView() {
        super.configureView()
        configureContentView()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
}

// MARK: - Configure

extension QuestionView {
    private func configureContentView() {
        backgroundColor = .systemBackground
        addSubviews([questionLabel,
                     editBtn])
    }
    
    func configureQuestionView(question: String, btnType: QuestionBtnType) {
        questionLabel.text = question
        editBtn.setImage(btnType.btnImage, for: .normal)
    }
}

// MARK: - Layout

extension QuestionView {
    private func configureLayout() {
        questionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(65)
            $0.centerY.equalToSuperview()
        }
        
        editBtn.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.trailing.equalToSuperview().offset(-15)
            $0.centerY.equalToSuperview()
        }
    }
}
