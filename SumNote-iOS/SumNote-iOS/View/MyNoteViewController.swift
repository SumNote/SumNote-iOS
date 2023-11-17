//
//  MyNoteViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/11/17.
//

import UIKit

import KakaoSDKUser
import Kingfisher

class MyNoteViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImageLabel: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImageLabel.layer.cornerRadius = 25
        setUserInfo()
    }
    
    private func setUserInfo(){
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            } else if let userInfo = KaKaoAPI.shared.extractUserInfo(user) {
                print("### Extracted User Info: \(userInfo)")
                self.userNameLabel.text = userInfo["nickname"] as? String
                let urlString = userInfo["profileImage"]
                let url = URL(string: urlString as! String)
                self.userImageLabel.kf.setImage(with:url)
                
                self.userEmailLabel.text = userInfo["email"] as? String
            }
        }
    }
    
}
