//
//  User.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2024/04/25.
//

import Foundation

struct UserInfo : Encodable, Decodable{
    var email : String?
    var name : String?
    
    init(email: String? = nil, name: String? = nil) {
        self.email = email
        self.name = name
    }
}
