//
//  SignUpViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import UIKit

class SignUpViewController: BaseViewController {
    let navigationBar: NavigationBar = NavigationBar()
    private var viewModel: UserViewModel = UserViewModel()
    
    @IBOutlet weak var idLabel: UILabel! {
        didSet {
            idLabel.font = UIFont.body2
        }
    }
    @IBOutlet weak var idTextField: UITextField! {
        didSet {
            idTextField.textColor = UIColor.orange100
            idTextField?.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange100, .font: UIFont.body1])
            idTextField.attributedPlaceholder = NSAttributedString(string: "아이디를 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray30, .font: UIFont.body1])
        }
    }
    @IBOutlet weak var passwordLabel: UILabel! {
        didSet {
            passwordLabel.font = UIFont.body2
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
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = UIFont.body2
        }
    }
    @IBOutlet weak var passwordCheckButton: UIButton! {
        didSet {
            passwordCheckButton.backgroundColor = UIColor.orange20
            passwordCheckButton.titleLabel?.font = UIFont.title2
            passwordCheckButton.setTitle(passwordCheckButton.titleLabel?.text ?? "", for: .normal)
            passwordCheckButton.setTitleColor(UIColor.orange100, for: .normal)
            passwordCheckButton.layer.cornerRadius = passwordCheckButton.height/2
        }
    }
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.textColor = UIColor.orange100
            nameTextField?.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange100, .font: UIFont.body1])
            nameTextField.attributedPlaceholder = NSAttributedString(string: "이름을 입력하세요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray30, .font: UIFont.body1])
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = UIFont.body2
        }
    }
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var validCheckButton: UIButton! {
        didSet {
            validCheckButton.backgroundColor = UIColor.orange20
            validCheckButton.titleLabel?.font = UIFont.title2
            validCheckButton.setTitle(validCheckButton.titleLabel?.text ?? "", for: .normal)
            validCheckButton.setTitleColor(UIColor.orange100, for: .normal)
            validCheckButton.layer.cornerRadius = validCheckButton.height/2
        }
    }
    @IBOutlet weak var signupButton: UIButton! {
        didSet {
            signupButton.backgroundColor = UIColor.orange100
            signupButton.titleLabel?.font = UIFont.title2
            signupButton.setTitle(signupButton.titleLabel?.text ?? "", for: .normal)
            signupButton.setTitleColor(UIColor.white, for: .normal)
            signupButton.layer.cornerRadius = signupButton.height/2
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
    
    var birthDay: String?
    var validId: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.naviType = .present
        navigationBar.configureNaviBar(targetVC: self, title: "회원가입")
        navigationBar.configureBackBtn(targetVC: self)
    }
}

/// Touch Event
extension SignUpViewController {
    @IBAction func onTouchValidCheckButton(_ sender: Any) {
        viewModel.postValidId(account_id: idTextField.text ?? "", completion: { [weak self] result in
            if result == true {
                // TODO: 추후에 ToastView노출
                print("아이디 사용 가능")
                self?.popupToast("아이디 사용 가능")
            } else {
                // TODO: 추후에 ToastView노출
                print("아이디 사용 불가")
                self?.popupToast("아이디 사용 불가")
            }
            self?.validId = result ?? false
        })
    }
    
    @IBAction func onTouchSignUpButton(_ sender: Any) {
        guard let account_id = idTextField.text,
              let password = passwordTextField.text,
              let name = nameTextField.text,
              let birthday = viewModel.dateTransForm(datePicker.date) else { print("잘못 입력된 값이 존재합니다."); return }
        if validId == true {
            viewModel.postSignUpAction(account_id: account_id, password: password, name: name, birthday: birthday, completion: { [weak self] in
                self?.presentHomeView()
            })
        } else {
            print("옳바른 아이디가 아닙니다.")
        }
    }
    
    @IBAction func onTouchPasswordCheckButton(_ sender: Any) {
        if passwordTextField.text == passwordConfirmTextField.text {
            print("동일")
            popupToast("동일")
        } else {
            print("다름")
            popupToast("다름")
        }
    }
}

/// Func
extension SignUpViewController {
    func presentHomeView() {
        let vc = HomeNavigationController()
        
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true)
    }
}
