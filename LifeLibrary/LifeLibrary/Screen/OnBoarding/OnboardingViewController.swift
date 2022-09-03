//
//  OnboardingViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

/// Touch Event
extension OnboardingViewController {
    @IBAction func onTouchLoginButton(_ sender: Any) {
        presentLoginView()
    }
    @IBAction func onTouchSignUpButton(_ sender: Any) {
        presentSignupView()
    }
}

/// Func
extension OnboardingViewController {
    func presentLoginView() {
        let vc = LoginViewController()
        
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func presentSignupView() {
        let vc = SignUpViewController()
        
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
}
