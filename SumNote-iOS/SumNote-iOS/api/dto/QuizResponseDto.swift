//
//  QuizResponseDto.swift
//  SumNote-iOS
//
//  Created by Choi76 on 5/2/24.
//

import Foundation

struct QuizResponseDto : Decodable {
    var data : [QuizDataDto]?
    var count : Int?
}

struct QuizDataDto : Decodable,Encodable {
    var question : String?
    var selection : [String]?
    var answer : String?
    var commentary : String?
}
