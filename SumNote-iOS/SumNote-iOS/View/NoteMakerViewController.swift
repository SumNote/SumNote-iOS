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
    
    private let imagePickerViewController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtnLayout() // 버튼 테두리 둥글게 적용
        imagePickerViewController.delegate = self
    }
    
    // 버튼 테두리 둥글게 적용
    private func setBtnLayout(){
        self.btnCamera.layer.cornerRadius = 25
        self.btnGallery.layer.cornerRadius = 25
    }
    
    //MARK: Camera Button Action
    @IBAction func btnCameraDidTapped(_ sender: Any) {
        // imagePicker의 타입 결정
        // 1. photoLibrary : 갤러리
        // 2. camera : 시스템 카메라
        self.imagePickerViewController.sourceType = .camera // 카메라로 선택
        self.present(imagePickerViewController,animated: true,completion: nil)
    }
    
    //MARK: Gallery Button Action
    @IBAction func btnGalleryDidTapped(_ sender: Any) {
        //1. imagePicker의 타입 선택
        self.imagePickerViewController.sourceType = .photoLibrary
        //2. NavigationController를 사용하여, ImagePickerContoller로 화면 전환
        // completion은 이후에 수행할 함수를 의미?
        self.present(imagePickerViewController,animated: true,completion: nil)
    }
}

// 뷰를 전환하기 위한 NavigationController와, 카메라,갤러리 뷰를 사용하기 위해 ImagePickerControllerDelegate 프로토콜을 채택한다.
extension NoteMakerViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    // 이미지가 선택된 후에, 아래 함수가 호출된다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print(image) // 사용자가 이미지를 선택하거나, 촬영하면 동작함
        }
        // 사용자가 선택한 이미지를 Multipart를 사용하여 서버로 전송하는 로직 작성 필요
        // OCR + GPT Generation이 진행중인 동안 indicator를 사용하여 화면에 로딩 띄우는 작업 필요
        // 로딩이 끝난 이후 노트 페이지로 이동 하는 작업 필요(네비게이션으로?)
    }
    
    
}
