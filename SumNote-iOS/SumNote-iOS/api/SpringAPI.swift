//
//  SpringAPI.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/29.
//

import Foundation
import Alamofire

class SpringAPI{
    
    static let shared = SpringAPI() // Singleton
    
    static let baseUrl = "http://127.0.0.1:8080/api"
    
    private init() {} // for singleton
    
    
    // 로그인
    func loginRequest(user : UserInfo, completion: @escaping (Bool) -> Void){
        let url = SpringAPI.baseUrl + "/member/login"
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success:
                    // Extract the token from the Authorization header
                    if let authToken = response.response?.headers.value(for: "Authorization") {
                        print("#SpringAPI-loginRequest: \(authToken)")
                        // 사용자 토큰 UserDefault에 저장
                        UserDefaults.standard.set(authToken, forKey: "jwtToken")
                        completion(true) // 로그인 성공시
                    } else {
                        print("#SpringAPI-loginRequest: No Token received")
                        completion(false) // 로그인 실패시
                    }
                case .failure(let error):
                    print("#SpringAPI-loginRequest: Error: \(error)")
                    completion(false)
                }
            }
    }
    
    
    // 기본적인 CRUD 작업
    
    // 사용자의 노트 데이터 요청(노트 목록)
    
    // 사용자의 특정 노트의 페이지 데이터 요청(페이지들)
    
    // 사용자의 문제집 데이터 요청(문제집 목록)
    
    // 사용자의 특정 문제집의 퀴즈 데이터 요청(문제집에 소속된 퀴즈들)
    
    // 사용자의 노트 삭제 요청
    
    // 사용자의 퀴즈 삭제 요청
    
}
