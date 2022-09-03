//
//  QuestionAnswerView.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit
import SnapKit
import Then
import UITextView_Placeholder

class QuestionAnswerView: BaseView {
    private let questionView = QuestionView()
        .then {
            $0.roundTopCorners(radius: 15)
        }
    
    private let answerTextView = UITextView()
        .then {
            $0.backgroundColor = .orange100
            $0.font = .title3
            $0.textColor = .white
            $0.placeholderColor = .orange30
            $0.setPadding()
            $0.roundBottomCorners(radius: 15)
        }
    
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

extension QuestionAnswerView {
    private func configureContentView() {
        addSubviews([questionView,
                     answerTextView])
    }
    
    func configureQuestionAnswerView(question: String,
                                     btnType: QuestionBtnType,
                                     placeholder: String,
                                     answer: String?) {
        questionView.configureQuestionView(question: question,
                                           btnType: btnType)
        answerTextView.placeholder = placeholder
        answerTextView.text = answer
    }
}

// MARK: - Layout

extension QuestionAnswerView {
    private func configureLayout() {
        questionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        answerTextView.snp.makeConstraints {
            $0.top.equalTo(questionView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(156)
        }
    }
}
