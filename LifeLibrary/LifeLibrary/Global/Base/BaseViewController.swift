//
//  BaseViewController.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class BaseViewController: UIViewController {
    
    // MARK: Properties
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    let keyboardWillShow = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
    let keyboardWillHide = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        layoutView()
        bindRx()
        hideKeyboard()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func layoutView() {}
    
    func bindRx() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {}
    
    func bindOutput() {}
}
