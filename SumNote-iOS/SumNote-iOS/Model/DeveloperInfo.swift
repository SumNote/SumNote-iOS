//
//  DeveloperInfo.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/11.
//

import Foundation

// 이미지 이름, 개발자 이름, 이메일, 역할1,2,3
struct DeveloperInfo {
    let imageName : String
    let devName : String
    let devEmail : String
    let role1 : String
    let role2 : String
    let role3 : String
    init(imageName: String, devName: String, devEmail: String, role1: String, role2: String, role3: String) {
        self.imageName = imageName
        self.devName = devName
        self.devEmail = devEmail
        self.role1 = role1
        self.role2 = role2
        self.role3 = role3
    }
}
