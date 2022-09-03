//
//  SettingViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/04.
//

import UIKit

class SettingViewController: BaseViewController {
    let navigationBar: NavigationBar = NavigationBar()

    private var viewModel: UserViewModel = UserViewModel()
    
    @IBOutlet weak var passwordLabel: UILabel! {
        didSet {
            passwordLabel.font = UIFont.body2
            passwordLabel.textColor = UIColor.black
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.body2
            nameLabel.textColor = UIColor.black
        }
    }
    @IBOutlet weak var birthLabel: UILabel! {
        didSet {
            birthLabel.font = UIFont.body2
            birthLabel.textColor = UIColor.black
        }
    }
    
    @IBOutlet weak var passwordView1: UIView! {
        didSet {
            passwordView1.layer.cornerRadius = passwordView1.height/2
            passwordView1.layer.borderWidth = 1
            passwordView1.layer.borderColor = UIColor.orange30.cgColor
            passwordView1.layer.opacity = 0.8
            passwordView1.addCardShadow()
            passwordView1.masksToBounds = false
        }
    }
    @IBOutlet weak var passwordView2: UIView! {
        didSet {
            passwordView2.layer.cornerRadius = passwordView2.height/2
            passwordView2.layer.borderWidth = 1
            passwordView2.layer.borderColor = UIColor.orange30.cgColor
            passwordView2.layer.opacity = 0.8
            passwordView2.addCardShadow()
            passwordView2.masksToBounds = false
        }
    }
    @IBOutlet weak var nameView: UIView! {
        didSet {
            nameView.layer.cornerRadius = nameView.height/2
            nameView.layer.borderWidth = 1
            nameView.layer.borderColor = UIColor.orange30.cgColor
            nameView.layer.opacity = 0.8
            nameView.addCardShadow()
            nameView.masksToBounds = false
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.textColor = UIColor.orange100
            nameTextField?.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange100, .font: UIFont.body1])
            nameTextField.attributedPlaceholder = NSAttributedString(string: "이름을 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray30, .font: UIFont.body1])
        }
    }
    
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.textColor = UIColor.orange100
            passwordTextField?.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange100, .font: UIFont.body1])
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray30, .font: UIFont.body1])
        }
    }
    
    @IBOutlet weak var passwordConfirmTextField: UITextField! {
        didSet {
            passwordConfirmTextField.textColor = UIColor.orange100
            passwordConfirmTextField?.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange100, .font: UIFont.body1])
            passwordConfirmTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 한 번 더 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray30, .font: UIFont.body1])
        }
    }
    
    @IBOutlet weak var passwordConfirmButton: UIButton! {
        didSet {
            passwordConfirmButton.backgroundColor = UIColor.orange20
            passwordConfirmButton.titleLabel?.font = UIFont.title2
            passwordConfirmButton.setTitle(passwordConfirmButton.titleLabel?.text ?? "", for: .normal)
            passwordConfirmButton.setTitleColor(UIColor.orange100, for: .normal)
            passwordConfirmButton.layer.cornerRadius = passwordConfirmButton.height/2
        }
    }
    
    @IBOutlet weak var completeButton: UIButton! {
        didSet {
            completeButton.backgroundColor = UIColor.orange100
            completeButton.titleLabel?.font = UIFont.title2
            completeButton.setTitle(completeButton.titleLabel?.text ?? "", for: .normal)
            completeButton.setTitleColor(UIColor.white, for: .normal)
            completeButton.layer.cornerRadius = completeButton.height/2
        }
    }
    @IBOutlet weak var logoutButton: UIButton! {
        didSet {
            logoutButton.backgroundColor = UIColor.white
            logoutButton.titleLabel?.font = UIFont.body3
            logoutButton.setTitle(logoutButton.titleLabel?.text ?? "", for: .normal)
            logoutButton.setTitleColor(UIColor.orange100, for: .normal)
            logoutButton.layer.cornerRadius = logoutButton.height/2
        }
    }
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.naviType = .push
        navigationBar.configureNaviBar(targetVC: self, title: "설정")
        navigationBar.configureBackBtn(targetVC: self)
    }
}

/// Touch Event
extension SettingViewController {
    @IBAction func onTouchPasswordConfirmButton(_ sender: Any) {
        if passwordTextField.text == passwordConfirmTextField.text {
            print("동일")
        } else {
            print("다름")
        }
    }
    @IBAction func onTouchCompletButton(_ sender: Any) {
        viewModel.putUserInfo(password: passwordTextField.text ?? "", name: nameTextField.text ?? "", birthday: viewModel.dateTransForm(datePicker.date) ?? "")
    }
    
    @IBAction func onTouchLogoutButton(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "access_token")
        UserDefaults.standard.set(0, forKey: "age")
        UserInfo.shared = UserInfo()
        
        
        view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
