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
    
    static var token : String? = nil
    
    private init() {} // for singleton
    
    
    // 로그인
    func loginRequest(user : UserInfo, completion: @escaping (Bool) -> Void){
        let url = SpringAPI.baseUrl + "/member/login"
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SpringBaseResponse<UserInfo>.self) { response in
                switch response.result {
                case .success:
                    // Extract the token from the Authorization header
                    if let authToken = response.response?.headers.value(for: "Authorization") {
                        print("📌SpringAPI-loginRequest: \(authToken)📌")
                        // 사용자 정보 저장
                        UserDefaults.standard.set(authToken, forKey: "token")
                        SpringAPI.token = authToken // 토큰 저장
                        completion(true) // 로그인 성공시
                    } else {
                        print("📌SpringAPI-loginRequest: No Token received📌")
                        completion(false) // 로그인 실패시
                    }
                case .failure(let error):
                    print("📌SpringAPI-loginRequest: Error: \(error)📌")
                    completion(false)
                }
            }
    }
    
    
    // 사용자의 노트 데이터 요청(노트 목록)
    func getNoteRequest(type : String){
        let url = SpringAPI.baseUrl + "/sum-note?type=\(type)"
        // ?type=home 노트 목록 5개 조회
        // ?type=all 노트 전체 반환

//        AF.request(url,
//                   method: .get,
//                   headers: HTTPHeaders(["Authorization" : SpringAPI.token!]))
//        .validate(statusCode: 200..<300)
//        .responseDecodable(of: SpringBaseResponse<[]>.self) { response in
//            switch response.result {
//            case .success:
//                if let data = response.data {
//                    print("#getNoteRequest : \(data)")
//                }
//            case .failure(let error):
//                print("#getNoteRequest error : \(error)")
//            }
//        }
        
    }

    
    // 사용자의 특정 노트의 페이지 데이터 요청(페이지들)
    
    // 사용자의 문제집 데이터 요청(문제집 목록)
    
    // 사용자의 특정 문제집의 퀴즈 데이터 요청(문제집에 소속된 퀴즈들)
    
    // 사용자의 노트 삭제 요청
    
    // 사용자의 퀴즈 삭제 요청
    
}
