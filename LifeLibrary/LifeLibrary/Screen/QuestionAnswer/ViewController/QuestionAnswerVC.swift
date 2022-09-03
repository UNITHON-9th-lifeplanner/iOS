//
//  QuestionAnswerVC.swift
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

class QuestionAnswerVC: BaseViewController {
    private let naviBar = NavigationBar()
    
    private let calendarTitle = UILabel()
        .then {
            $0.font = .title2
            $0.textColor = .label
        }
    
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
            
            $0.appearance.weekdayFont = .body3
            $0.appearance.weekdayTextColor = .label
            
            $0.appearance.titleFont = .body2
            $0.appearance.titleDefaultColor = .label
            
            $0.appearance.titleTodayColor = .white
            $0.appearance.todayColor = .main
            
            $0.appearance.selectionColor = .white
            $0.appearance.titleSelectionColor = .main
            
            $0.appearance.borderSelectionColor = .main
        }
    
    private let viewModel = QuestionAnswerVM()
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
        bindDaySelect()
    }
    
}

// MARK: - Configure

extension QuestionAnswerVC {
    private func configureNaviBar() {
        naviBar.naviType = .push
        naviBar.configureNaviBar(targetVC: self, title: nil)
        naviBar.configureBackBtn(targetVC: self)
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
        calendar.delegate = self
    }
    
    private func calendarPrepareForReuse() {
        calendar.collectionView.visibleCells.forEach {
            $0.layer.shadowOpacity = 0
        }
    }
}

// MARK: - Layout

extension QuestionAnswerVC {
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

extension QuestionAnswerVC {
    private func bindBtn() {
        nextMonthBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.input.moveMonth.accept(1)
                self.calendar.select(self.viewModel.input.selectedDay.value)
                self.calendarPrepareForReuse()
            })
            .disposed(by: bag)
        
        prevMonthBtn.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self  else { return }
                self.viewModel.input.moveMonth.accept(-1)
                self.calendar.select(self.viewModel.input.selectedDay.value)
                self.calendarPrepareForReuse()
            })
            .disposed(by: bag)
    }
}

// MARK: - Output

extension QuestionAnswerVC {
    private func bindDaySelect() {
        viewModel.input.selectedDay
            .asDriver()
            .drive(onNext: { [weak self] day in
                guard let self = self,
                      let cell = self.calendar.cell(for: day, at: .current)
                else { return }
                // 선택 일자 색 구별
                self.calendar.appearance.selectionColor
                = self.viewModel.isToday(day)
                ? .main : .white
                
                self.calendar.appearance.titleSelectionColor
                = self.viewModel.isToday(day)
                ? .white : .main
                
                cell.addDayShadow()
            })
            .disposed(by: bag)
    }
}

// MARK: - FSCalendarDelegate

extension QuestionAnswerVC: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.input.selectedDay.accept(date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let cell = calendar.cell(for: date, at: .current) else { return }
        cell.layer.shadowOpacity = 0
    }
}
