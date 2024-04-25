//
//  LoginResponse.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2024/04/25.
//

import Foundation

// 공통적인 응답 형태
// status, data, message
struct SpringBaseResponse<T : Decodable>: Decodable {
    var status: Int?
    var data: T
    var message: String?
}
