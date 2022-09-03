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
            return UIImage(named: "confirm") ?? UIImage()
        case .edit:
            return UIImage(named: "edit") ?? UIImage()
        case .delete:
            return UIImage(named: "delete") ?? UIImage()
        }
    }
    
    var btnSelectedImage: UIImage {
        switch self {
        case .done:
            return UIImage(named: "confirm_Selected") ?? UIImage()
        case .edit:
            return UIImage(named: "edit_Selected") ?? UIImage()
        case .delete:
            return UIImage(named: "delete_Selected") ?? UIImage()
        }
    }
}
