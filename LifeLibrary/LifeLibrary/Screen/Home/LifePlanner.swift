//
//  LifePlanner.swift
//  LifeLibrary
//
//  Created by USER on 2022/09/04.
//

import Foundation

// MARK: - LifePlanner
struct LifePlanner: Codable {
    let ageGroup: String
    let isMyAge: Bool
    let lifeGoalContent: String?
    let popularKeywords: [String]
    
    enum CodingKeys: String, CodingKey {
        case ageGroup = "age_group"
        case isMyAge = "is_my_age"
        case lifeGoalContent = "life_goal_content"
        case popularKeywords = "popular_keywords"
    }
}
