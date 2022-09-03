//
//  KeywordViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/04.
//

import UIKit

class KeywordViewController: BaseViewController {
    var selectAge: String?
    @IBOutlet weak var dividerView: UIView! {
        didSet {
            dividerView.backgroundColor = UIColor.gray10
        }
    }
    
    @IBOutlet weak var keywordTitle: UILabel! {
        didSet {
            keywordTitle.textColor = UIColor.black
            keywordTitle.font = UIFont.title3
            keywordTitle.text = (selectAge ?? "") + "대 전체 인기 키워드"
        }
    }
    
    @IBOutlet weak var ageKeyword: UILabel! {
        didSet {
            ageKeyword.textColor = UIColor.black
            ageKeyword.font = UIFont.title3
        }
    }
    
    @IBOutlet weak var keywordView1: UIView! {
        didSet {
            keywordView1.layer.cornerRadius = keywordView1.height/2
            keywordView1.layer.borderWidth = 1
            keywordView1.layer.borderColor = UIColor.orange30.cgColor
            keywordView1.layer.opacity = 0.8
            keywordView1.addCardShadow()
            keywordView1.masksToBounds = false
        }
    }
    @IBOutlet weak var keywordView2: UIView! {
        didSet {
            keywordView2.layer.cornerRadius = keywordView2.height/2
            keywordView2.layer.borderWidth = 1
            keywordView2.layer.borderColor = UIColor.orange30.cgColor
            keywordView2.layer.opacity = 0.8
            keywordView2.addCardShadow()
            keywordView2.masksToBounds = false
        }
    }
    @IBOutlet weak var keywordView3: UIView! {
        didSet {
            keywordView3.layer.cornerRadius = keywordView3.height/2
            keywordView3.layer.borderWidth = 1
            keywordView3.layer.borderColor = UIColor.orange30.cgColor
            keywordView3.layer.opacity = 0.8
            keywordView3.addCardShadow()
            keywordView3.masksToBounds = false
        }
    }
    @IBOutlet weak var keywordView4: UIView! {
        didSet {
            keywordView4.layer.cornerRadius = keywordView4.height/2
            keywordView4.layer.borderWidth = 1
            keywordView4.layer.borderColor = UIColor.orange30.cgColor
            keywordView4.layer.opacity = 0.8
            keywordView4.addCardShadow()
            keywordView4.masksToBounds = false
        }
    }
    @IBOutlet weak var keywordView5: UIView! {
        didSet {
            keywordView4.layer.cornerRadius = keywordView4.height/2
            keywordView4.layer.borderWidth = 1
            keywordView4.layer.borderColor = UIColor.orange30.cgColor
            keywordView4.layer.opacity = 0.8
            keywordView4.addCardShadow()
            keywordView4.masksToBounds = false
        }
    }
    
    @IBOutlet weak var keyword1: UITextField!
    @IBOutlet weak var keyword2: UITextField!
    @IBOutlet weak var keyword3: UITextField!
    @IBOutlet weak var keyword4: UITextField!
    @IBOutlet weak var keyword5: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
