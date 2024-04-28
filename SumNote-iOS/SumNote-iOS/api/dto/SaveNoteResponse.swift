//
//  addNoteResponse.swift
//  SumNote-iOS
//
//  Created by Choi76 on 4/28/24.
//

import Foundation

struct SaveNoteResponse : Decodable {
    var status : Int?
    var data : Data?
    var message : String?
}
