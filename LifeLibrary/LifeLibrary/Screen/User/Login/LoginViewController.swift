//
//  LoginViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import UIKit

class LoginViewController: BaseViewController {
    let navigationBar: NavigationBar = NavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.naviType = .push
        navigationBar.configureNaviBar(targetVC: self, title: "로그인화면")
        navigationBar.configureBackBtn(targetVC: self)
    }
}
