//
//  ChallengeInputVC.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/04.
//

import UIKit
import RxCocoa
import RxGesture
import RxSwift
import SnapKit
import Then

class ChallengeInputVC: BaseViewController {
    private let questionLabel = UILabel()
        .then {
            $0.text = "10대의 ‘나’를 되돌아본다면?"
            $0.font = .title3
        }
    
    private let textCntLabel = UILabel()
        .then {
            $0.text = "(0/100)"
            $0.font = .body3
        }
    
    private let answerTextView = UITextView()
        .then {
            $0.font = .title1
            $0.textColor = .label
            $0.text = "인삼 밭의 행복한 고구마였다.\n지금 내가 인삼이 아니고 고구마라는 것을 깨달은 것이 문제지만..."
            $0.isEditable = false
        }
    
    private let keywordScrollView = UIScrollView()
        .then {
            $0.backgroundColor = .systemBackground
        }
    
    private let keywordTitleLabel = UILabel()
        .then {
            $0.text = "키워드를 골라주세요 ~"
            $0.font = .title3
            $0.backgroundColor = .systemBackground
        }
    
    private let keywordCntLabel = UILabel()
        .then {
            $0.text = "(0/5)"
            $0.font = .body3
        }
    
    private let keywordCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        .then {
            let layout = CollectionViewLeftAlignFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 12
            layout.minimumInteritemSpacing = 8
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            
            $0.collectionViewLayout = layout
            $0.allowsMultipleSelection = true
        }
    
    private let keywordInputView = UIView()
        .then {
            $0.layer.cornerRadius = 52 / 2
            $0.addCardShadow()
            $0.backgroundColor = .systemBackground
        }
    
    private let poundBtn = UILabel()
        .then {
            $0.text = "#"
            $0.font = .title3
            $0.textColor = .orange100
        }
    
    private let keywordInputTextField = UITextField()
        .then {
            $0.font = .title3
            $0.textColor = .orange100
            $0.placeholder = "새로운 키워드를 입력해보새요"
            $0.setPlaceHolderTextColor(.orange30)
        }
    
    private let keywordInputBtn = UIButton()
        .then {
            $0.backgroundColor = .orange100
            $0.setImage(UIImage(systemName: "plus"), for: .normal)
            $0.layer.cornerRadius = 36 / 2
            $0.tintColor = .white
        }
    
    var keywords = [
        "갓생",
        "공부",
        "공인중개사",
        "나이",
        "노을",
        "대학교",
        "대학생활",
        "돈",
        "머니",
        "배움",
        "부동산",
        "사랑",
        "세계로",
        "아시아",
        "아프리카",
        "안주",
        "유럽",
        "잠",
        "젊음",
        "졸업",
        "책",
        "컴퓨터",
        "파이어",
        "홍대",
        "후회"
    ]
    
    private var isKeyword = false
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureContentView()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
    override func bindInput() {
        super.bindInput()
    }
    
    override func bindOutput() {
        super.bindOutput()
    }
    
}

// MARK: - Helpers

extension ChallengeInputVC {
    func setQuestions(_ text: String) {
        questionLabel.text = text
    }
    
    func setAnswers(_ text: String) {
        answerTextView.text = text
        textCntLabel.text = "(\(text.count)/100)"
    }
    
    func setSelectKeyword(idx: [Int]) {
        idx.forEach {
            keywordCV.selectItem(at: [0, $0], animated: true, scrollPosition: .centeredVertically)
        }
        keywordCntLabel.text = "(\(idx.count)/5)"
    }
}

// MARK: - Configure

extension ChallengeInputVC {
    private func configureContentView() {
        view.addSubviews([questionLabel,
                          textCntLabel,
                          answerTextView,
                          keywordScrollView,
                          keywordTitleLabel,
                          keywordCntLabel])
        keywordScrollView.addSubviews([keywordCV,
                                       keywordInputView])
        keywordInputView.addSubviews([poundBtn,
                                      keywordInputTextField,
                                      keywordInputBtn])
        
        keywordCV.register(KeywordCVC.self, forCellWithReuseIdentifier: KeywordCVC.className)
        keywordCV.dataSource = self
        keywordCV.delegate = self
    }
}

// MARK: - Layout

extension ChallengeInputVC {
    private func configureLayout() {
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(36)
            $0.leading.equalToSuperview().offset(20)
        }
        
        textCntLabel.snp.makeConstraints {
            $0.centerY.equalTo(questionLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        answerTextView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalTo(keywordScrollView.snp.top)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        keywordScrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
            $0.height.equalTo(246)
        }
        
        keywordTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(keywordScrollView.snp.top)
            $0.leading.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(64)
        }
        
        keywordCntLabel.snp.makeConstraints {
            $0.centerY.equalTo(keywordTitleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        keywordCV.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(162)
        }
        
        keywordInputView.snp.makeConstraints {
            $0.top.equalTo(keywordCV.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
        }
        
        poundBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        keywordInputTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(poundBtn.snp.trailing).offset(4)
        }
        
        keywordInputBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(56)
            $0.height.equalTo(36)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
}

// MARK: - Input

extension ChallengeInputVC {
    
}

// MARK: - Output

extension ChallengeInputVC {
    
}

extension ChallengeInputVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCVC.className, for: indexPath) as? KeywordCVC else { fatalError() }
        cell.configureCell(keyword: keywords[indexPath.row])
        
        return cell
    }
}

class CollectionViewLeftAlignFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 8
 
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 10.0
        let attributes = super.layoutAttributesForElements(in: rect)
 
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
