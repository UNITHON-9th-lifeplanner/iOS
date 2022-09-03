//
//  HomeNavigationController.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/04.
//

import UIKit

class HomeNavigationController: BaseNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([HomeViewController()], animated: true)
    }
}
