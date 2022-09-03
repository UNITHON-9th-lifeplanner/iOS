//
//  KeywordViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/04.
//

import UIKit

class KeywordViewController: BaseViewController {
    var selectAge: String?
    var keywords: [String]?
    var popularKeywords: PopularKeyword?
    private var viewModel: HomeViewModel = HomeViewModel()
    @IBOutlet weak var dividerView: UIView! {
        didSet {
            dividerView.backgroundColor = UIColor.gray10
        }
    }
    
    @IBOutlet weak var keywordTitle: UILabel! {
        didSet {
            keywordTitle.textColor = UIColor.black
            keywordTitle.font = UIFont.title3
            keywordTitle.text = (selectAge ?? "") + " 전체 인기 키워드"
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
            keywordView5.layer.cornerRadius = keywordView5.height/2
            keywordView5.layer.borderWidth = 1
            keywordView5.layer.borderColor = UIColor.orange30.cgColor
            keywordView5.layer.opacity = 0.8
            keywordView5.addCardShadow()
            keywordView5.masksToBounds = false
        }
    }
    
    @IBOutlet weak var keyword1: UITextField!
    @IBOutlet weak var keyword2: UITextField!
    @IBOutlet weak var keyword3: UITextField!
    @IBOutlet weak var keyword4: UITextField!
    @IBOutlet weak var keyword5: UITextField!
    
    @IBOutlet weak var popularKeywordView: UIView! {
        didSet {
            popularKeywordView.layer.cornerRadius = 15.0
            popularKeywordView.backgroundColor = UIColor.orange100
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIFont.title3
            titleLabel.textColor = UIColor.white
        }
    }
    
    @IBOutlet weak var popularView1: UIView! {
        didSet {
            popularView1.layer.cornerRadius = popularView1.height/2
            popularView1.backgroundColor = UIColor.white
        }
    }
    @IBOutlet weak var popularView2: UIView! {
        didSet {
            popularView2.layer.cornerRadius = popularView2.height/2
            popularView2.backgroundColor = UIColor.white
        }
    }
    @IBOutlet weak var popularView3: UIView! {
        didSet {
            popularView3.layer.cornerRadius = popularView3.height/2
            popularView3.backgroundColor = UIColor.white
        }
    }
    @IBOutlet weak var popularView4: UIView! {
        didSet {
            popularView4.layer.cornerRadius = popularView4.height/2
            popularView4.backgroundColor = UIColor.white
        }
    }
    @IBOutlet weak var popularView5: UIView! {
        didSet {
            popularView5.layer.cornerRadius = popularView5.height/2
            popularView5.backgroundColor = UIColor.white
        }
    }
    
    @IBOutlet weak var popularKeyword1: UILabel! {
        didSet {
            popularKeyword1.font = UIFont.title3
            popularKeyword1.textColor = UIColor.black
        }
    }
    @IBOutlet weak var popularKeyword2: UILabel! {
        didSet {
            popularKeyword2.font = UIFont.title3
            popularKeyword2.textColor = UIColor.black
        }
    }
    
    @IBOutlet weak var popularKeyword3: UILabel! {
        didSet {
            popularKeyword3.font = UIFont.title3
            popularKeyword3.textColor = UIColor.black
        }
    }
    @IBOutlet weak var popularKeyword4: UILabel! {
        didSet {
            popularKeyword4.font = UIFont.title3
            popularKeyword4.textColor = UIColor.black
        }
    }
    @IBOutlet weak var popularKeyword5: UILabel! {
        didSet {
            popularKeyword5.font = UIFont.title3
            popularKeyword5.textColor = UIColor.black
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chacngeKeyword()
        let result = selectAge?.components(separatedBy: "대")
        viewModel.getPopularKeyword(age_Group: result?[0] ?? "", completion: { [weak self] keywords in
            self?.popularKeywords = keywords
        })
    }
}

extension KeywordViewController {
    func chacngeKeyword() {
        keyword1.text = "# " + (keywords?[0] ?? "" )
        keyword2.text = "# " + (keywords?[1] ?? "" )
        keyword3.text = "# " + (keywords?[2] ?? "" )
        keyword4.text = "# " + (keywords?[3] ?? "" )
        keyword5.text = "# " + (keywords?[4] ?? "" )
    }
    
    func changePopularKeyword() {
        popularKeyword1.text = "1   # " + (popularKeywords?.currentPopularKeywords[0] ?? "" )
        if popularKeywords?.currentPopularKeywords.count ?? 0 < 2 { return }
        popularKeyword2.text = "2   # " + (popularKeywords?.currentPopularKeywords[1] ?? "" )
        if popularKeywords?.currentPopularKeywords.count ?? 0 < 3 { return }
        popularKeyword3.text = "3   # " + (popularKeywords?.currentPopularKeywords[2] ?? "" )
        if popularKeywords?.currentPopularKeywords.count ?? 0 < 4 { return }
        popularKeyword4.text = "4   # " + (popularKeywords?.currentPopularKeywords[3] ?? "" )
        if popularKeywords?.currentPopularKeywords.count ?? 0 < 5 { return }
        popularKeyword5.text = "5   # " + (popularKeywords?.currentPopularKeywords[4] ?? "" )
    }
}
