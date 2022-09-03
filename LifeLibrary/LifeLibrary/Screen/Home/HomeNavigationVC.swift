//
//  HomeNavigationVC.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/04.
//

import Foundation

class HomNavigationVC: BaseNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([HomeViewController()], animated: true)
    }
}
