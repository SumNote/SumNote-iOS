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
        // Do any additional setup after loading the view.
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
                // 1. 스토리보드 찾기
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                // 2. 이동할 뷰 찾기 => 스토리보드의 identifier릁 통해
                let tabBarController = storyboard
                    .instantiateViewController(identifier: "TabBarController") as TabBarController
                tabBarController.modalPresentationStyle = .fullScreen //전체 화면으로 변경
                // 3. 화면 이동
                self.present(tabBarController, animated: true)
            }
        }
        
    }
    
}
