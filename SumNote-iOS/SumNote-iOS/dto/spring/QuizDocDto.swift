//
//  QuizDocDto.swift
//  SumNote-iOS
//
//  Created by Choi76 on 5/3/24.
//

import Foundation

struct QuizDocDto : Decodable {
    var quizId : Int
    var title : String?
    var createdAt : String?
    var lastModifiedAt : String?
    
    // for Data Mapping
    enum CodingKeys: String, CodingKey {
        case quizId = "quiz"
        case title
        case createdAt
        case lastModifiedAt
    }
}
