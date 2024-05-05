//
//  QuizDataDto.swift
//  SumNote-iOS
//
//  Created by Choi76 on 5/3/24.
//

import Foundation

// 특정 문제집안의 퀴즈들 조회
struct QuizPageDataDto : Decodable,Encodable {
    var quizId : Int?
    var quiz : [QuizPageDto]?
}

struct QuizPageDto : Decodable,Encodable {
    var quizPageId : Int?
    var question : String?
    var selection : [QuizSelectionDto]?
    var answer : String?
    var commentary : String? // 해설
}

struct QuizSelectionDto : Decodable,Encodable {
    var selection : String?
}
