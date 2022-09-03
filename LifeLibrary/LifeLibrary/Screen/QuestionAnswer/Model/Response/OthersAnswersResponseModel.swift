//
//  OthersAnswersResponseModel.swift
//  LifeLibrary
//
//  Created by 황윤경 on 2022/09/04.
//

import Foundation

struct OthersAnswersResponseModel: Codable {
    let question: String
    let answers: [Answer]
}

// MARK: - Answer
struct Answer: Codable {
    let answerID: Int
    let answer, anonymousWriter, answeredAt: String

    enum CodingKeys: String, CodingKey {
        case answerID = "answer_id"
        case answer
        case anonymousWriter = "anonymous_writer"
        case answeredAt = "answered_at"
    }
}
