//
//  CreateNoteDto.swift
//  SumNote-iOS
//
//  Created by Choi76 on 4/30/24.
//

import Foundation

struct CreateNoteDto : Encodable, Decodable {
    var note : noteDto?
    var notePages : [SaveNotePageDto]?
}

struct noteDto : Encodable, Decodable {
    var title : String?
}

