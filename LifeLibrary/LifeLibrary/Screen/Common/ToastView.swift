//
//  ToastView.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/04.
//

import UIKit
import SnapKit
import Then

class ToastView: BaseView {
    private let toastMessage = UILabel()
        .then {
            $0.font = .body3
            $0.textColor = .white
            $0.textAlignment = .center
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

extension ToastView {
    private func configureContentView() {
        backgroundColor = UIColor.init(white: 0, alpha: 0.75)
        layer.cornerRadius = 5
        
        addSubview(toastMessage)
    }
    
    func configureToastView(_ message: String) {
        toastMessage.text = message
    }
}

// MARK: - Layout

extension ToastView {
    private func configureLayout() {
        toastMessage.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
