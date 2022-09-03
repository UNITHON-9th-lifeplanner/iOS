//
//  UIView+.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit

extension UIView {
    //UIView에 다수의 Subviews 한번에 추가
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    /// UIView 상단에만 round를 주는 함수
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner,
                               .layerMinXMinYCorner]
    }
    
    /// view를 담당하는 viewController를 찾는 함수
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    /// view에 shadow를 추가하는 함수
    func addDayShadow(opacity: Float = 0.8) {
        layer.shadowColor = UIColor.orange100.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
    }
    
    func addCardShadow(opacity: Float = 0.8) {
        layer.shadowColor = UIColor.orange30.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = .zero
        layer.shadowRadius = 3
    }
}
