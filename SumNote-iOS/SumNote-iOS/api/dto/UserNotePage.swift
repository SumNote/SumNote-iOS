//
//  UserNotePage.swift
//  SumNote-iOS
//
//  Created by Choi76 on 4/27/24.
//

import Foundation

struct UserNotePage : Decodable,Encodable {
    var note : NotePageNoteDto?
    var notePages: [NotePagesDto]?
}

struct NotePageNoteDto : Decodable, Encodable{
    var noteId : Int?
    var title : String?
}

struct NotePagesDto : Decodable, Encodable {
    var notePageId : Int?
    var title : String?
    var content : String?
    var isQuizExist : Bool?
}

struct SaveNotePageDto : Encodable, Decodable {
    var title : String?
    var content : String?
}
