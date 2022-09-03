//
//  LoginViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import UIKit

class LoginViewController: BaseViewController {
    let navigationBar: NavigationBar = NavigationBar()
    private var account_id: String = ""
    private var password: String = ""
    private var viewModel: UserViewModel = UserViewModel()
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.naviType = .push
        navigationBar.configureNaviBar(targetVC: self, title: "로그인화면")
        navigationBar.configureBackBtn(targetVC: self)
    }
    
    @IBAction func onTouchLoginButton(_ sender: Any) {
        account_id = idTextField.text ?? ""
        password = passwordTextField.text ?? ""
        loginAction()
    }
}

extension LoginViewController {
    func loginAction() {
        viewModel.postLoginAction(account_id: account_id, password: password)
    }
}
