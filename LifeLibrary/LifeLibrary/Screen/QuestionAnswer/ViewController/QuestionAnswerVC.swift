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
    
    private let baseScrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let calendarTitle = UILabel()
        .then {
            $0.font = .title2
            $0.textColor = .label
        }
    
    private let nextMonthBtn = UIButton()
        .then {
            $0.setImage(UIImage(named: "nextMonthBtn"), for: .normal)
            $0.setImage(UIImage(named: "nextMonthBtn_Selected"), for: .highlighted)
        }
    
    private let prevMonthBtn = UIButton()
        .then {
            $0.setImage(UIImage(named: "prevMonthBtn"), for: .normal)
            $0.setImage(UIImage(named: "prevMonthBtn_Selected"), for: .highlighted)
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
            $0.appearance.todayColor = .orange100
            
            $0.appearance.selectionColor = .white
            $0.appearance.titleSelectionColor = .orange100
            
            $0.appearance.borderSelectionColor = .orange100
            $0.appearance.eventDefaultColor = .orange100
            $0.appearance.eventSelectionColor = .orange100
            
            $0.scrollEnabled = false
        }
    
    private let questionAnswerView = QuestionAnswerView()
        .then {
            $0.addCardShadow()
        }
    
    private let showAnswerListBtn = UIButton()
        .then {
            $0.setTitle("다른 유저들의 답변 둘러보기 >>", for: .normal)
            $0.titleLabel?.font = .body3
            $0.setTitleColor(.gray30, for: .normal)
        }
    
    private var answerDates: [String]?
    
    private let viewModel = QuestionAnswerVM()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAnswerDates(date: .now)
        viewModel.getDayQnA(date: .now)
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
        bindCalendar()
        bindKeyboardScroll()
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
        view.addSubview(baseScrollView)
        baseScrollView.addSubview(contentView)
        contentView.addSubviews([calendarTitle,
                                 prevMonthBtn,
                                 nextMonthBtn,
                                 calendar,
                                 questionAnswerView,
                                 showAnswerListBtn])
        
        configureCalendarTitle(date: .now)
        calendar.delegate = self
        calendar.dataSource = self
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
        baseScrollView.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().priority(.low)
        }
        
        calendarTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
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
        
        questionAnswerView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(228)
        }
        
        showAnswerListBtn.snp.makeConstraints {
            $0.top.equalTo(questionAnswerView.snp.bottom).offset(13)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
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
                ? .orange100 : .white
                
                self.calendar.appearance.titleSelectionColor
                = self.viewModel.isToday(day)
                ? .white : .orange100
                
                cell.addDayShadow()
            })
            .disposed(by: bag)
        
        viewModel.output.dayResponse
            .subscribe(onNext: { [weak self] data in
                guard let self = self,
                      let date = data.answeredAt.toDate()
                else { return }
                
                var btnType: QuestionBtnType = .none
                var placeholder = ""
                
                if data.answer == nil {
                    placeholder = self.viewModel.isToday(date)
                    ? "오늘의 질문에 대한 답변을\n자유롭게 작성해주세요."
                    : "작성된 답변이 없습니다.\n아쉽네요.."
                    btnType = self.viewModel.isToday(date) ? .edit : .none
                } else {
                    btnType = self.viewModel.isToday(date) ? .edit : .delete
                }
                
                self.questionAnswerView.configureQuestionAnswerView(question: data.question,
                                                                    btnType: btnType,
                                                                    placeholder: placeholder,
                                                                    answer: data.answer)
            })
            .disposed(by: bag)
        
        viewModel.output.noneQuestion
            .subscribe(onNext: { [weak self] error in
                guard let self = self else { return }
                self.questionAnswerView.configureQuestionAnswerView(question: error,
                                                                    btnType: .none,
                                                                    placeholder: "",
                                                                    answer: nil)
            })
            .disposed(by: bag)
    }
    
    private func bindCalendar() {
        viewModel.output.answerDates
            .asDriver()
            .drive(onNext: {[weak self] dates in
                guard let self = self else { return }
                self.answerDates = dates
                self.calendar.reloadData()
            })
            .disposed(by: bag)
    }
    
    private func bindKeyboardScroll() {
        keyboardWillShow
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.baseScrollView.scrollToBottom(animated: true)
            })
            .disposed(by: bag)
    }
}

// MARK: - FSCalendarDelegate

extension QuestionAnswerVC: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.input.selectedDay.accept(date)
        viewModel.getDayQnA(date: date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        guard let cell = calendar.cell(for: date, at: .current) else { return }
        cell.layer.shadowOpacity = 0
    }
}

extension QuestionAnswerVC: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        guard let dates = answerDates,
              let date = date.toString()
        else { return 0 }
        return dates.contains(date) ? 1 : 0
    }
}
