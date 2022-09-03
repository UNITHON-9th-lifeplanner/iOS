//
//  OthersAnswersTVC.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit
import SnapKit
import Then

class OthersAnswersTVC: UITableViewCell {
    private let baseView = UIView()
        .then {
            $0.backgroundColor = .systemBackground
            $0.addCardShadow()
        }
    
    private let ageGroupLabel = UILabel()
        .then {
            $0.font = .body2
            $0.textColor = .orange100
        }
    
    private let dateLabel = UILabel()
        .then {
            $0.font = .body3
            $0.textColor = .gray30
            $0.textAlignment = .right
        }
    
    private let separator = UIView()
        .then {
            $0.backgroundColor = .gray10
        }
    
    private let answerLabel = UILabel()
        .then {
            $0.setLineBreakMode()
            $0.font = .title3
            $0.textColor = .label
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        layoutView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ageGroupLabel.text = "익명의 -대"
        dateLabel.text = nil
        answerLabel.text = nil
    }
}

// MARK: - Configure

extension OthersAnswersTVC {
    private func configureView() {
        addSubview(baseView)
        baseView.addSubviews([ageGroupLabel,
                                 dateLabel,
                                 separator,
                                 answerLabel])
        baseView.layer.cornerRadius = 15
        baseView.backgroundColor = .systemBackground
        baseView.addCardShadow()
    }
    
    private func layoutView() {
        baseView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-6)
        }
        
        ageGroupLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(ageGroupLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(ageGroupLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        answerLabel.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func configureCell(with item: Answer) {
        ageGroupLabel.text = item.anonymousWriter
        dateLabel.text = item.answeredAt.split(separator: "-").joined(separator: ".")
        answerLabel.text = item.answer
    }
}
