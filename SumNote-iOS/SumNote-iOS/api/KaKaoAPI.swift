//
//  KaKaoAPI.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/11/17.
//

import Foundation

// Kakao api pod file
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

// KaKao App Information
// https://developers.kakao.com/console/app/995002

// Reference
// https://sujinnaljin.medium.com/ios-%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%86%A1-%EC%86%8C%EC%85%9C-%EB%A1%9C%EA%B7%B8%EC%9D%B8-58a525e6f219

// 카카오 계정과 관련된 작업을 수행하기 위한 싱글톤 객체
class KaKaoAPI{
    
    static let shared = KaKaoAPI() //Singleton Reference
    
    private init() {} //외부 생성 금지(Singleton)
    
    //사용자 정보 추출
    func extractUserInfo(_ userInfo: User?) -> [String: Any]? {
        print("call extractUserInfo :\(String(describing: userInfo))")
        guard let userInfo = userInfo, let properties = userInfo.properties else {
            print("extractUserInfo Data binding failed")
            return nil
        }

        // 딕셔너리로 추출한 데이터 반환
        var extractedInfo: [String: Any] = [:]
        extractedInfo["nickname"] = properties["nickname"]
        extractedInfo["profileImage"] = properties["profile_image"]
        extractedInfo["thumbnailImage"] = properties["thumbnail_image"]
        
        // kakaoAccount에서 이메일 정보 추출
        if let email = userInfo.kakaoAccount?.email {
            extractedInfo["email"] = email
        }
        
        print("binding data : \(extractedInfo)")
        
        //닉네임, 프로필이미지, 썸네일이미지 반환
        return extractedInfo
    }

    
    
}
