//
//  UITextView+.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit

extension UITextView {
    /// setTextViewToViewer - textView를 드래그 불가 뷰어용으로 설정
    func setTextViewToViewer() {
        isScrollEnabled = false
        isUserInteractionEnabled = false
    }
    
    /// setPadding - textView 기본 padding값 설정
    func setPadding() {
        self.textContainerInset = UIEdgeInsets(top: 18, left: 10, bottom: 18, right: 10)
    }
}
