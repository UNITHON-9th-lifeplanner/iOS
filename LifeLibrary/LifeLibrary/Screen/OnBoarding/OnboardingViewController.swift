//
//  OnboardingViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import UIKit
import SnapKit

class OnboardingViewController: BaseViewController {
    private var account_id: String = ""
    private var password: String = ""
    private var viewModel: UserViewModel = UserViewModel()
    
    @IBOutlet weak var idTextField: UITextField! {
        didSet {
            idTextField.textColor = UIColor.orange100
            idTextField?.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange100, .font: UIFont.body1])
            idTextField.attributedPlaceholder = NSAttributedString(string: "아이디를 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray30, .font: UIFont.body1])
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.textColor = UIColor.orange100
            passwordTextField?.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange100, .font: UIFont.body1])
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray30, .font: UIFont.body1])
        }
    }
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.backgroundColor = UIColor.orange100
            loginButton.titleLabel?.font = UIFont.title2
            loginButton.setTitle(loginButton.titleLabel?.text ?? "", for: .normal)
            loginButton.setTitleColor(UIColor.white, for: .normal)
            loginButton.layer.cornerRadius = loginButton.height/2
        }
    }
    
    @IBOutlet weak var idView: UIView! {
        didSet {
            idView.layer.cornerRadius = idView.height/2
            idView.layer.borderWidth = 1
            idView.layer.borderColor = UIColor.orange30.cgColor
            idView.layer.opacity = 0.8
            idView.addCardShadow()
            idView.masksToBounds = false
        }
    }
    @IBOutlet weak var passwordView: UIView! {
        didSet {
            passwordView.layer.cornerRadius = passwordView.height/2
            passwordView.layer.borderWidth = 1
            passwordView.layer.borderColor = UIColor.orange30.cgColor
            passwordView.layer.opacity = 0.8
            passwordView.addCardShadow()
            passwordView.masksToBounds = false
        }
    }
    
    @IBOutlet weak var leftDividerView: UIView! {
        didSet {
            leftDividerView.backgroundColor = UIColor.gray10
        }
    }
    
    @IBOutlet weak var rightDividerView: UIView! {
        didSet {
            rightDividerView.backgroundColor = UIColor.gray10
        }
    }
    
    @IBOutlet weak var requestSignupLabel: UILabel! {
        didSet {
            requestSignupLabel.textColor = UIColor.gray30
            requestSignupLabel.font = UIFont.body3
        }
    }
    
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
            signupButton.backgroundColor = UIColor.orange20
            signupButton.titleLabel?.font = UIFont.title2
            signupButton.setTitle(signupButton.titleLabel?.text ?? "", for: .normal)
            signupButton.setTitleColor(UIColor.orange100, for: .normal)
            signupButton.layer.cornerRadius = signupButton.height/2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension OnboardingViewController {
    @IBAction func onTouchLoginButton(_ sender: Any) {
        account_id = idTextField.text ?? ""
        password = passwordTextField.text ?? ""
        loginAction()
    }
    
    @IBAction func onTouchSignupButton(_ sender: Any) {
        signupAction()
    }
}

extension OnboardingViewController {
    func loginAction() {
        viewModel.postLoginAction(account_id: account_id, password: password, completion: { [weak self] result in
            if result == "" {
                self?.presentHomeView()
            } else {
                self?.popupToast(result)
            }
        })
    }
    
    func signupAction() {
        let vc = SignUpViewController()
        
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true)
    }
    
    func presentHomeView() {
        let vc = HomeNavigationController()
        
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true)
    }
}
