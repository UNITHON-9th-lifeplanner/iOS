//
//  QuestionBtnType.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import UIKit

enum QuestionBtnType {
    case done
    case edit
    case delete
}

extension QuestionBtnType {
    var btnImage: UIImage {
        switch self {
        case .done:
            return UIImage(named: "") ?? UIImage()
        case .edit:
            return UIImage(named: "") ?? UIImage()
        case .delete:
            return UIImage(named: "") ?? UIImage()
        }
    }
}