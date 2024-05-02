//
//  CreateQuizRequestParameter.swift
//  SumNote-iOS
//
//  Created by Choi76 on 5/3/24.
//

import Foundation

struct CreateQuizRequestParameter : Encodable{
    var noteId : Int?
    var title : String?
    var quiz : [QuizDataDto]?
}
