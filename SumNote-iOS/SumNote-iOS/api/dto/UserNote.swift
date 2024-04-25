//
//  UserNote.swift
//  SumNote-iOS
//
//  Created by Choi76 on 4/26/24.
//

import Foundation

struct UserNote : Decodable {
    var noteId : Int?
    var title : String?
    var createdAt : String?
    var lastModifiedAt : String?
}
