//
//  DjangoAPI.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/29.
//

import Foundation
import Alamofire // api

class FastAPI{
    
    static let shared = FastAPI()
    
    static let baseURL = "http://192.168.174.183:8000"
    
    private let session: Session
    
    private init() { // for singleton
        // 세션 설정으로 타임아웃 조정
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120 // 요청에 대한 타임아웃을 120초로 설정
        configuration.timeoutIntervalForResource = 120 // 리소스 타임아웃을 120초로 설정
        self.session = Session(configuration: configuration)
    }
    
    // multipart 방식으로 이미지를 RequestBody에 삽입해서 OCR 결과물 얻어옴
    // key-name : "image"
    public func makeNoteByImageRequest(image : UIImage, completion : @escaping (Bool,CreatedNoteResult?) -> Void){
        let url = FastAPI.baseURL + "/image-to-text"
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]

        // UIImage를 Data로 변환
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            self.log("makeNoteByImageRequest : failed to convert image")
            completion(false, nil)
            return
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.method = .post
        request.headers = headers
        request.timeoutInterval = 120 // 개별 요청 타임아웃 설정
        

        session.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
        }, with: request).responseDecodable(of: CreatedNoteResult.self) { response in
            switch response.result {
            case .success(let apiResponse):
                let createdNote = apiResponse
                self.log("makeNoteByImageRequest : note created successfully \(String(describing: createdNote.sum_result))")
                completion(true, createdNote)
            case .failure(let error):
                self.log("makeNoteByImageRequest : image send fail \(error)")
                completion(false, nil)
            }
        }
    }
        
    
    // multipart 방식으로 PDF파일을 RequestBody에 삽입해서 OCR 결과물 얻어옴
    // key-name : "pdf"
    public func makeNoteByPdf(pdfURL: URL, completion: @escaping (Bool, CreatedNoteResult?) -> Void) {
            let url = FastAPI.baseURL + "/pdf-to-text"
            let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]

            // URLRequest를 만들고 타임아웃 설정 적용
            var request = URLRequest(url: URL(string: url)!)
            request.method = .post
            request.headers = headers
            request.timeoutInterval = 120 // 개별 요청 타임아웃 설정

            // PDF 파일을 Data 객체로 변환
            guard let pdfData = try? Data(contentsOf: pdfURL) else {
                self.log("Failed to load PDF file")
                completion(false, nil)
                return
            }

            // Alamofire를 사용하여 MultipartFormData 방식으로 PDF 파일 업로드
            session.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(pdfData, withName: "pdf", fileName: "document.pdf", mimeType: "application/pdf")
            }, with: request).responseDecodable(of: CreatedNoteResult.self) { response in
                switch response.result {
                case .success(let createdNote):
                    self.log("makeNoteByPdf: PDF processed successfully")
                    completion(true, createdNote)
                case .failure(let error):
                    self.log("makeNoteByPdf: Failed to upload PDF - \(error.localizedDescription)")
                    completion(false, nil)
                }
            }
        }
    
    
    // 퀴즈 생성 요청
    public func makeQuizRequest(){
        print("Quiz 데이터 얻어옴..")
    }
    
}

extension FastAPI {
    private func log(_ message: String){
        print("🛜[FastAPI] \(message)🛜")
    }
}
