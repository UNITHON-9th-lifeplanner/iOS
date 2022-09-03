//
//  QuestionResponseModel.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/03.
//

import Foundation

struct QuestionResponseModel: Codable {
    let questionID: Int
    let question: String
    let answerID: Int?
    let answer: String?
    let answeredAt: String
    
    enum CodingKeys: String, CodingKey {
        case questionID = "question_id"
        case question
        case answerID = "answer_id"
        case answer
        case answeredAt = "answered_at"
    }
}
