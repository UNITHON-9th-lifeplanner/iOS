//
//  SignUpViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import UIKit

class SignUpViewController: BaseViewController {

    private var viewModel: UserViewModel = UserViewModel()
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmLabel: UILabel!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var validCheckButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    var birthDay: String?
    var validId: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

/// Touch Event
extension SignUpViewController {
    @IBAction func onTouchValidCheckButton(_ sender: Any) {
        viewModel.postValidId(account_id: idTextField.text ?? "", completion: { [weak self] result in
            if result == true {
                // TODO: 추후에 ToastView노출
                print("아이디 사용 가능")
            } else {
                // TODO: 추후에 ToastView노출
                print("아이디 사용 불가")
            }
            self?.validId = result ?? false
        })
    }
    
    @IBAction func onTouchSignUpButton(_ sender: Any) {
        guard let account_id = idTextField.text,
              let password = passwordTextField.text,
              let name = nameTextField.text,
              let birthday = dateTransForm(datePicker.date) else { print("잘못 입력된 값이 존재합니다."); return }
        if validId == true {
            viewModel.postSignUpAction(account_id: account_id, password: password, name: name, birthday: birthday)
        } else {
            print("옳바른 아이디가 아닙니다.")
        }
    }
}

/// Func
extension SignUpViewController {
    func dateTransForm(_ date: Date?) -> String? {
        return date?.string(withFormat: "yyyy-MM-dd")
    }
}
