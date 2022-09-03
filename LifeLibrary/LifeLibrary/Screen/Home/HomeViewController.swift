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
            dragMainView.roundCorners([.topLeft, .topRight], radius: 20.0)
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
    
    let dropDown = DropDown()
    let ageList = ["10대", "20대", "30대", "40대", "50대", "60대"]
    var selectAge: String?
    var viewVelocity = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag))
        dragView.addGestureRecognizer(panGesture)
        viewModel.getMyPlan(age_Group: userInfo.age?.string ?? "", completion: { [weak self] content in
            self?.planTextView.text = content
        })
    }
}

/// Touch Event
extension HomeViewController {
    @IBAction func onTouchDropDown(_ sender: Any) {
        dropDown.show()
    }
}

extension HomeViewController {
    func initUI() {
        DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
        DropDown.appearance().textFont = UIFont.body2
        DropDown.appearance().selectedTextColor = UIColor.black // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor(white: 1, alpha: 0.9) // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
        dropDown.dismissMode = .automatic // 팝업을 닫을 모드 설정
        
        if let firstIndex = ageList.firstIndex(of: (userInfo.age?.string ?? "") + "대") {
            planAge.text = ageList[firstIndex]
            self.keywordTitle.text = ageList[firstIndex] + " 전체 인기 키워드"
        }
        selectAge = userInfo.age?.string ?? ""
        setDropdown()
    }
    
    func setDropdown() {
        // dataSource로 ItemList를 연결
        dropDown.dataSource = ageList
        
        // anchorView를 통해 UI와 연결
        dropDown.anchorView = self.dropView
        
        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        dropDown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        
        // Item 선택 시 처리
        dropDown.selectionAction = { [weak self] (index, item) in
            //선택한 Item을 TextField에 넣어준다.
            self?.planAge.text = item
            self?.keywordTitle.text = item + " 전체 인기 키워드"
            self?.selectAge = item
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
            print("이 값이 어떻게 변하는지 확인 \(translation.y)")
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
        
        self.present(vc, animated: true)
    }
}
