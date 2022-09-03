//
//  HomeViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var mainView: UIView! {
        didSet {
            mainView.backgroundColor = UIColor.orange100
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
