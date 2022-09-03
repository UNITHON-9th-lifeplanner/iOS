//
//  BaseView.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit
import SnapKit
import Then

class BaseView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureView()
        layoutView()
    }
    
    // MARK: - Functions
    
    func configureView() {}
    
    func layoutView() {}
}
