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
    
    static let baseUrl = "http://localhost:8080/api"
//    static let baseUrl = "http://52.78.139.114:8080/api"
    
    static var token : String? = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJjaGxya2QxMjIxQGdtYWlsLmNvbSIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE3MTQzNTMwNzIsImV4cCI6MTcxNTU2MjY3Mn0.V4RHTl1HBy3D8MJVy73soHb50fkVEhIIWFMKv1Bl3mM"
    
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
                        self.log("loginRequest success : \(authToken)")
                        // 사용자 정보 저장
                        UserDefaults.standard.set(authToken, forKey: "token")
                        SpringAPI.token = authToken // 토큰 저장
                        completion(true) // 로그인 성공시
                    } else {
                        self.log("loginRequest success : No Token received")
                        completion(false) // 로그인 실패시
                    }
                case .failure(let error):
                    self.log("loginRequest fail : \(error)")
                    completion(false)
                }
            }
    }
    
    
    // 사용자의 노트 데이터 요청(노트 목록)
    func getNoteRequest(type : String, completion : @escaping (Bool,[NoteDto])->Void){
        let url = SpringAPI.baseUrl + "/sum-note?type=\(type)"
        // ?type=home 노트 목록 5개 조회
        // ?type=all 노트 전체 반환
        AF.request(url,
                   method: .get,
                   headers: HTTPHeaders(["Authorization" : SpringAPI.token!]))
        .validate(statusCode: 200..<300)
        .responseDecodable(of: SpringBaseResponse<[NoteDto]>.self) { response in
            switch response.result {
            case .success(let apiResponse):
                let noteList = apiResponse.data
                self.log("getNoteRequest success \(String(describing: apiResponse.message))")
                completion(true,noteList)
            case .failure(let error):
                self.log("getNoteRequest error : \(error)")
                completion(false,[])
            }
        }
        
    }
    
    // 사용자의 특정 노트의 페이지 데이터 요청(페이지들)
    func getNotePagesReqeust(noteId : Int, completion : @escaping (Bool,UserNotePage?)->()){
        let url = SpringAPI.baseUrl + "/sum-note/\(noteId)"
        
        AF.request(url,
                   method: .get,
                   headers: HTTPHeaders(["Authorization" : SpringAPI.token!]))
        .validate(statusCode: 200..<300)
        .responseDecodable(of: SpringBaseResponse<UserNotePage>.self) { response in
            switch response.result{
            case .success(let apiResponse):
                let requestResult = apiResponse.data
                self.log("getNotePagesReqeust \(String(describing: apiResponse.message))")
                self.log("getNotePagesReqeust success : \(String(describing: requestResult.notePages))")
                completion(true,requestResult)
            case .failure(let error):
                self.log("getNotePagesReqeust error : \(error)")
                completion(false,nil)
            }
        }
    }
    
    // 특정 노트에 페이지 추가 저장
    func savePageToNoteRequest(noteId : Int, notePage : SaveNotePageDto, completion : @escaping (Bool)->(Void)){
        let url = SpringAPI.baseUrl + "/sum-note/\(noteId)/add"
        
        AF.request(url,
                   method: .put,
                   parameters: notePage,
                   encoder: JSONParameterEncoder.default,
                   headers: HTTPHeaders(["Authorization" : SpringAPI.token!]))
        .validate(statusCode: 200..<300)
        .responseDecodable(of: SpringDataNUllResponse.self){ response in
            switch response.result{
            case .success(let apiResponse):
                self.log("savePageToNoteRequest success \(apiResponse)")
                completion(true)
            case .failure(let error):
                self.log("savePageToNoteRequest success \(error)")
                completion(false)
            }
        }
    }
    
    // 새로운 노트 생성 후 페이지 저장
    func savePageToNewNoteRequest(newNote : CreateNoteDto, completion : @escaping (Bool)->(Void)){
        let url = SpringAPI.baseUrl + "/sum-note"
        
        AF.request(url,
                   method: .post,
                   parameters: newNote,
                   encoder: JSONParameterEncoder.default,
                   headers: HTTPHeaders(["Authorization" : SpringAPI.token!]))
        .validate(statusCode: 200..<300)
        .responseDecodable(of : SpringDataNUllResponse.self){ response in
            switch response.result{
            case .success(let apiResponse):
                self.log("savePageToNewNoteRequest success \(apiResponse)")
                completion(true)
            case .failure(let error):
                self.log("savePageToNewNoteRequest success \(error)")
                completion(false)
            }
        }
    }

    // 노트 이름 바꾸기
    func changeNoteNameRequest(noteId : Int, changeNoteParameter : ChangeNoteParameter, completion : @escaping (Bool)->(Void)){
        let url = SpringAPI.baseUrl + "/sum-note/\(noteId)/title"
        
        AF.request(url, 
                   method: .put,
                   parameters: changeNoteParameter,
                   encoder: JSONParameterEncoder.default,
                   headers: HTTPHeaders(["Authorization" : SpringAPI.token!]))
        .validate(statusCode: 200..<300)
        .responseDecodable(of : SpringDataNUllResponse.self){ response in
            switch response.result{
            case .success(let apiResponse):
                self.log("changeNoteNameRequest success \(apiResponse)")
                completion(true)
            case .failure(let error):
                self.log("changeNoteNameRequest success \(error)")
                completion(false)
            }
        }
    }
    
    // 사용자의 노트 삭제 요청
    
    
    
    
    
    // 문제집 생성 요청
    func createQuizDocRequest(parameter : CreateQuizRequestParameter, completion : @escaping (Bool)->(Void)){
        let url = SpringAPI.baseUrl + "/quiz"
        
        // POST
        AF.request(url,
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: HTTPHeaders(["Authorization" : SpringAPI.token!]))
        .validate(statusCode: 200..<300)
        .responseDecodable(of : SpringDataNUllResponse.self){ response in
            switch response.result{
            case .success(let apiResponse):
                self.log("createQuizDocRequest success \(String(describing: apiResponse.message))")
                completion(true)
            case .failure(let error):
                self.log("createQuizDocRequest success \(error)")
                completion(false)
            }
        }
        
    }
    
    
    // 사용자의 문제집 데이터 요청(문제집 목록)
    func getQuizRequest(type : String, completion : @escaping (Bool,[QuizDocDto])->Void){
        let url = SpringAPI.baseUrl + "/quiz?type=\(type)"
        // ?type=home 퀴즈 목록 5개 조회
        // ?type=all 퀴즈 전체 반환
        AF.request(url,
                   method: .get,
                   headers: HTTPHeaders(["Authorization" : SpringAPI.token!]))
        .validate(statusCode: 200..<300)
        .responseDecodable(of: SpringBaseResponse<[QuizDocDto]>.self) { response in
            switch response.result {
            case .success(let apiResponse):
                let quizDocList = apiResponse.data
                self.log("getNoteRequest success \(String(describing: apiResponse.message))")
                completion(true,quizDocList)
            case .failure(let error):
                self.log("getNoteRequest error : \(error)")
                completion(false,[])
            }
        }
        
    }
    
    	
    // 사용자의 특정 문제집의 퀴즈 데이터 요청(문제집에 소속된 퀴즈들)
    
    
    //

}

extension SpringAPI {
    private func log(_ message: String){
        print("🛜[SpringAPI] \(message)🛜")
    }
}
