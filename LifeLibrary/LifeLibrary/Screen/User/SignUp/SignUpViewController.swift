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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

/// Touch Event
extension SignUpViewController {
    @IBAction func onTouchValidCheckButton(_ sender: Any) {
        
    }
    
    @IBAction func onTouchSignUpButton(_ sender: Any) {
        birthDay = dateTransForm(datePicker.date)
    }
}

/// Func
extension SignUpViewController {
    func dateTransForm(_ date: Date?) -> String? {
        return date?.string(withFormat: "yyyy-MM-dd")
    }
}
