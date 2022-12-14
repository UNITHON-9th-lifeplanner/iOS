//
//  HomeViewController.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/03.
//

import UIKit
import DropDown

class HomeViewController: UIViewController {
    var userInfo = UserInfo.shared
    private var viewModel: HomeViewModel = HomeViewModel()
    
    @IBOutlet var mainView: UIView! {
        didSet {
            mainView.backgroundColor = UIColor.orange100
        }
    }
    @IBOutlet weak var dividerView: UIView! {
        didSet {
            dividerView.backgroundColor = UIColor.gray10
        }
    }
    @IBOutlet weak var dragMainView: UIView! {
        didSet {
            dragMainView.layer.cornerRadius = 20.0
        }
    }
    @IBOutlet weak var dragView: UIView!
    
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var planAge: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    @IBOutlet weak var planTextView: UITextView! {
        didSet {
            planTextView.font = UIFont.home
            planTextView.textColor = UIColor.white
        }
    }
    
    @IBOutlet weak var keywordTitle: UILabel! {
        didSet {
            keywordTitle.textColor = UIColor.black
            keywordTitle.font = UIFont.title3
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
    
    let dropDown = DropDown()
    let ageList = ["10???", "20???", "30???", "40???", "50???", "60???"]
    var selectAge: String?
    var viewVelocity = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag))
        dragView.addGestureRecognizer(panGesture)
        viewModel.getMyPlan(age_Group: userInfo.age?.string ?? "", completion: { [weak self] content in
            self?.planTextView.text = content
            self?.changeKeyword()
        })
    }
}

/// Touch Event
extension HomeViewController {
    @IBAction func onTouchDropDown(_ sender: Any) {
        dropDown.show()
    }
    @IBAction func onTouchSettingButton(_ sender: Any) {
        let vc = SettingViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(vc)
//        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onTouchEditButton(_ sender: Any) {
        let inputVC = InputVC()
        inputVC.modalPresentationStyle = .fullScreen
        self.present(inputVC, animated: true)
    }
    
    @IBAction func onTouchQuestionButton(_ sender: Any) {
        let questionAnswerVC = QuestionAnswerVC()
        self.navigationController?.pushViewController(questionAnswerVC)
    }
}

extension HomeViewController {
    func initUI() {
        DropDown.appearance().textColor = UIColor.black // ????????? ????????? ??????
        DropDown.appearance().textFont = UIFont.body2
        DropDown.appearance().selectedTextColor = UIColor.black // ????????? ????????? ????????? ??????
        DropDown.appearance().backgroundColor = UIColor(white: 1, alpha: 0.9) // ????????? ?????? ?????? ??????
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // ????????? ????????? ?????? ??????
        dropDown.dismissMode = .automatic // ????????? ?????? ?????? ??????
        
        if let firstIndex = ageList.firstIndex(of: (userInfo.age?.string ?? "") + "???") {
            planAge.text = ageList[firstIndex]
            self.keywordTitle.text = ageList[firstIndex] + " ?????? ?????? ?????????"
        }
        selectAge = userInfo.age?.string ?? ""
        setDropdown()
    }
    
    func setDropdown() {
        // dataSource??? ItemList??? ??????
        dropDown.dataSource = ageList
        
        // anchorView??? ?????? UI??? ??????
        dropDown.anchorView = self.dropView
        
        // View??? ????????? ?????? View????????? Item ????????? ????????? ??????
        dropDown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        
        // Item ?????? ??? ??????
        dropDown.selectionAction = { [weak self] (index, item) in
            //????????? Item??? TextField??? ????????????.
            self?.planAge.text = item
            self?.keywordTitle.text = item + " ?????? ?????? ?????????"
            self?.selectAge = item
            let result = item.components(separatedBy: "???")
            self?.viewModel.getMyPlan(age_Group: result[0], completion: { content in
                self?.planTextView.text = content
                self?.changeKeyword()
            })
        }
    }
    
    @objc func drag(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        viewVelocity = sender.velocity(in: self.view)
        
        switch sender.state {
        case .changed:
            if viewVelocity.y < 0 {
                UIView.animate(withDuration: 0.1, animations: {
                    self.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
                })
            }
        case .ended:
            if translation.y > -100 {
                UIView.animate(withDuration: 0.1, animations: {
                    self.view.transform = .identity
                })
            } else {
                presentKeywordView()
                UIView.animate(withDuration: 0.1, animations: {
                    self.view.transform = .identity
                })
            }
        default:
            break
        }
    }
    
    func presentKeywordView() {
        let vc = KeywordViewController()
        
        vc.keywords = viewModel.keywords
        if selectAge?.contains("???") != true {
            vc.selectAge = selectAge
        } else {
            vc.selectAge = (selectAge ?? "") + "???"
        }
        
        self.present(vc, animated: true)
    }
    
    func changeKeyword() {
        if viewModel.keywords.isEmpty {
            return
        }
        keyword1.text = "# " + (viewModel.keywords[0] )
        keyword2.text = "# " + (viewModel.keywords[1] )
        keyword3.text = "# " + (viewModel.keywords[2] )
        keyword4.text = "# " + (viewModel.keywords[3] )
        keyword5.text = "# " + (viewModel.keywords[4] )
    }
}
