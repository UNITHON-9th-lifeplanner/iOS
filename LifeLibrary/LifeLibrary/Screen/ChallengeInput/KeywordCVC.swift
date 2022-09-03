//
//  KeywordCVC.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/04.
//

import UIKit
import Then
import SnapKit

class KeywordCVC: UICollectionViewCell {
    private let keywordLabel = UILabel()
        .then {
            $0.font = .title3
            $0.textColor = .orange100
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContent()
    }
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                backgroundColor = .orange100
                keywordLabel.textColor = .white
            } else {
                backgroundColor = .orange10
                keywordLabel.textColor = .orange100
            }
        }
    }
    
    private func configureContent() {
        addSubview(keywordLabel)
        backgroundColor = .orange10
        layer.cornerRadius = 44 / 2
        keywordLabel.textColor = .orange100
        keywordLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func configureCell(keyword: String) {
        keywordLabel.text = "# \(keyword)"
    }
}
