//
//  OthersAnswersVC.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxDataSources
import SnapKit
import Then

class OthersAnswersVC: BaseViewController {
    private let baseScrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let questionLabel = UILabel()
        .then {
            $0.font = .title1
            $0.textColor = .label
            $0.setLineBreakMode()
        }
    
    private let answersTV = UITableView()
        .then {
            $0.separatorStyle = .none
            $0.allowsSelection = false
        }
    
    private let naviBar = NavigationBar()
    private let viewModel = OthersAnswersVM()
    private let bag = DisposeBag()
    
    var questionID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getProceedingChallengeList(questionID: questionID ?? 1)
    }
    
    override func configureView() {
        super.configureView()
        configureNaviBar()
        configureContentView()
        configureAnswersTV()
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
        bindQuestion()
        bindTableView()
    }
    
}

// MARK: - Helpers

extension OthersAnswersVC {
    
}

// MARK: - Configure

extension OthersAnswersVC {
    private func configureContentView() {
        view.addSubview(baseScrollView)
        baseScrollView.addSubview(contentView)
        contentView.addSubviews([questionLabel,
                                 answersTV])
    }
    
    private func configureNaviBar() {
        naviBar.naviType = .push
        naviBar.configureNaviBar(targetVC: self, title: nil)
        naviBar.configureBackBtn(targetVC: self)
    }
    
    private func configureAnswersTV() {
        answersTV.register(OthersAnswersTVC.self,
                           forCellReuseIdentifier: OthersAnswersTVC.className)
        answersTV.delegate = self
    }
}

// MARK: - Layout

extension OthersAnswersVC {
    private func configureLayout() {
        baseScrollView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(76)
        }
        
        answersTV.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - Input

extension OthersAnswersVC {
    
}

// MARK: - Output

extension OthersAnswersVC {
    func bindTableView() {
        viewModel.output.dataSource
            .bind(to: answersTV.rx.items(dataSource: tableViewDataSource()))
            .disposed(by: bag)
        
        viewModel.output.answerList
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.answersTV.reloadData()
            })
            .disposed(by: bag)
    }
    
    func bindQuestion() {
        viewModel.output.question
            .withUnretained(self)
            .subscribe(onNext: { owner, question in
                owner.questionLabel.text = question
            })
            .disposed(by: bag)
    }
}

// MARK: - DataSource
extension OthersAnswersVC {
    func tableViewDataSource() -> RxTableViewSectionedReloadDataSource<OthersAnswersDataSource> {
        RxTableViewSectionedReloadDataSource<OthersAnswersDataSource>(
            configureCell: { _, tableView, indexPath, item in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: OthersAnswersTVC.className,
                    for: indexPath
                ) as? OthersAnswersTVC else {
                    fatalError()
                }
                // 등록
                cell.configureCell(with: item)
                
                return cell
            })
    }
}

// MARK: - UITableViewDelegate

extension OthersAnswersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
