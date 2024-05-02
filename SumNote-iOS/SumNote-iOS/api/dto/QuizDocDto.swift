//
//  QuizDocDto.swift
//  SumNote-iOS
//
//  Created by Choi76 on 5/3/24.
//

import Foundation

struct QuizDocDto : Decodable {
    var quiz : Int // quizId
    var title : String?
    var createdAt : String?
    var lastModifiedAt : String?
}
