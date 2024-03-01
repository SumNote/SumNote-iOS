//
//  DjangoAPI.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/29.
//

import Foundation
import Alamofire // api

class DjangoAPI{
    
    static let shared = DjangoAPI()
    
    private init() {} // for singleton
    
    
    // 이미지 자체를 put방식으로 전송하여, Django서버로부터 OCR 결과물을 얻어옴 => String
    public func getOCR(){
        print("ocr 결과물 얻어옴..")
    }
    
    
    // OCR된 문자열을 서버로 전송하여, GPT API에 퀴즈 데이터 요청
    public func getQuiz(){
        print("Quiz 데이터 얻어옴..")
    }
    
}
