//
//  NoteMakerViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/11/17.
//

import UIKit


// 사용자가 찍은 사진을 서버로 전송하여 노트 생성 화면으로 이동
class NoteMakerViewController: UIViewController {

    //MARK: layout
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setBtnLayout()
    }
    
    // 버튼 테두리 둥글게 적용
    private func setBtnLayout(){
        self.btnCamera.layer.cornerRadius = 25
        self.btnGallery.layer.cornerRadius = 25
    }
    
    //MARK: Camera Button Action
    @IBAction func btnCameraDidTapped(_ sender: Any) {
        
    }
    
    //MARK: Gallery Button Action
    @IBAction func btnGalleryDidTapped(_ sender: Any) {
        
    }
}
