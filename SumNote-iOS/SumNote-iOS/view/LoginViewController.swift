//
//  ViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/11/17.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnKaKaoLogin: UIButton! //카카오 로그인 버튼
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnKaKaoLogin.layer.cornerRadius = 20 // 버튼 테두리 둥글게
    }
    
    
    // 카카오 계정으로 시작하기 버튼 클릭시
    @IBAction func kakaoLoginBtnDidTapped(_ sender: Any) {
        // 카카오 로그인 띄우기
        // 웹사이트를 사용하여 카카오톡 로그인 화면 띄우기
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print("KaKao Login Error : \(error)")
            } else {
                self.requestUserInfo()
            }
        }
        
    }
    
    // 카카오 API로 사용자 정보 요청
    private func requestUserInfo(){
        UserApi.shared.me { (user, error) in
            if let error = error {
                print("Failed to request user info: \(error)")
            } else if let user = user {
                print("User info request successful")
                
                if let email = user.kakaoAccount?.email, let nickname = user.kakaoAccount?.profile?.nickname {
                    self.springLogin(email: email, name: nickname)
                } else {
                    print("Necessary user info not available")
                }
            }
        }
    }
    
    // 스프링 서버로 로그인 요청
    private func springLogin(email: String, name: String){
        let user = UserInfo(email: email, name: name)
        SpringAPI.shared.loginRequest(user: user)
        
        DispatchQueue.main.async {
            // 1. 스토리보드 찾기
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // 2. 이동할 뷰 찾기 => 스토리보드의 identifier를 통해
            let tabBarController = storyboard
                .instantiateViewController(identifier: "TabBarController") as TabBarController
            tabBarController.modalPresentationStyle = .fullScreen //전체 화면으로 변경
            // 3. 화면 이동
            self.present(tabBarController, animated: true)
        }
    }
    
}
