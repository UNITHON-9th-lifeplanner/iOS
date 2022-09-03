//
//  QuestionVC.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit
import Then
import FSCalendar

class QuestionVC: BaseViewController {
    private let naviBar = NavigationBar()
    
    private let calendarTitle = UILabel()
    
    private let nextMonthBtn = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        }
    
    private let prevMonthBtn = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        }
    
    private let calendar = FSCalendar()
        .then {
            $0.locale = Locale(identifier: "ko_KR")
            $0.headerHeight = 0
            $0.weekdayHeight = 32
            $0.scope = .month
        }
    
    private let viewModel = QuestionVM()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        configureNaviBar()
        configureContentView()
    }
    
    override func layoutView() {
        super.layoutView()
        configureLayout()
    }
    
    override func bindInput() {
        super.bindInput()
        bindBtn()
    }
    
    override func bindOutput() {
        super.bindOutput()
    }
    
}

// MARK: - Configure

extension QuestionVC {
    private func configureNaviBar() {
        naviBar.naviType = .push
        naviBar.configureNaviBar(targetVC: self, title: nil)
    }
    
    private func configureCalendarTitle(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월"
        
        calendarTitle.text = dateFormatter.string(from: date)
    }
    
    private func configureContentView() {
        view.addSubviews([calendarTitle,
                          prevMonthBtn,
                          nextMonthBtn,
                          calendar])
        configureCalendarTitle(date: .now)
    }
}

// MARK: - Layout

extension QuestionVC {
    private func configureLayout() {
        calendarTitle.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        nextMonthBtn.snp.makeConstraints {
            $0.leading.equalTo(calendarTitle.snp.trailing).offset(8)
            $0.centerY.equalTo(calendarTitle)
            $0.width.height.equalTo(24)
        }
        
        prevMonthBtn.snp.makeConstraints {
            $0.trailing.equalTo(calendarTitle.snp.leading).offset(-8)
            $0.centerY.equalTo(calendarTitle)
            $0.width.height.equalTo(24)
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(calendarTitle.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(300)
        }
    }
}

// MARK: - Input

extension QuestionVC {
    private func bindBtn() {
        nextMonthBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.input.moveMonth.accept(1)
                self.calendar.select(self.viewModel.input.selectedDay.value)
            })
            .disposed(by: bag)
        
        prevMonthBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.input.moveMonth.accept(-1)
                self.calendar.select(self.viewModel.input.selectedDay.value)
            })
            .disposed(by: bag)
    }
}

// MARK: - Output

extension QuestionVC {
    
}
