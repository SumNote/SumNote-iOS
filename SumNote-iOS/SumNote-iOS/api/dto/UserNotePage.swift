//
//  UserNotePage.swift
//  SumNote-iOS
//
//  Created by Choi76 on 4/27/24.
//

import Foundation

struct UserNotePage : Decodable{
    var note : NotePageNoteDto?
    var notePages: [NotePagesDto]?
}

struct NotePageNoteDto : Decodable {
    var noteId : Int?
    var title : String?
}

struct NotePagesDto : Decodable {
    var notePageId : Int?
    var title : String?
    var content : String?
    var isQuizExist : Bool?
}
