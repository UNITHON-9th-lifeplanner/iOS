//
//  UIViewController+.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit

extension UIViewController {
    
    /// className을 String으로 반환하는 프로퍼티
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
    var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    /// 화면 터치 시 키보드 내리는 함수
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// 화면 터치 시 키보드 내리는 함수
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    /// 에러 Alert 메서드
    func showErrorAlert(_ message: String?) {
        let alertController = UIAlertController(title: "Error",
                                                message: message,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "Confirm",
                                   style: .default)
        
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
    
    /// 로딩을 보여주는 메서드
    func loading(loading: Bool) {
        if loading {
            let loadingView = LoadingView(frame: view.frame)
            view.addSubview(loadingView)
            return
        }
        
        guard let loadingView = view.subviews.compactMap({ $0 as? LoadingView }).first else { return }
        loadingView.removeFromSuperview()
    }
    
    func popupToast(_ message: String) {
        let toastView = ToastView(frame: CGRect(x: 20, y: -46, width: UIScreen.main.bounds.size.width - 40, height: 46))
        toastView.configureToastView(message)
        view.addSubview(toastView)
        
        UIView.animate(withDuration: 0.2) {
            toastView.snp.updateConstraints {
                $0.top.equalToSuperview().offset(62)
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().offset(-20)
                $0.height.equalTo(46)
            }
            self.view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.2, delay: 1, options: .curveEaseOut, animations: {
                toastView.snp.updateConstraints {
                    $0.top.equalToSuperview().offset(-46)
                }
                self.view.layoutIfNeeded()
            }, completion: {_ in
                toastView.removeFromSuperview()
            })
        }
    }
}
