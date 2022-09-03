//
//  OnboardingNavigationVC.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import Foundation

class OnboardingNavigationVC: BaseNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([OnboardingViewController()], animated: true)
    }
}
