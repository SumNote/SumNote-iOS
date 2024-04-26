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
    @IBOutlet weak var btnPdf: UIButton!
    
    private let imagePickerViewController = UIImagePickerController()
    
    weak var delegate : NavigationDelegate? // 위임자 선언 => MyNoteTableViewController(메인화면)
    
    var createdNote : CreatedNoteResult?
    
    private let stoaryBoard = UIStoryboard(name: "Main", bundle: nil)
    
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBtnLayout() // 버튼 테두리 둥글게 적용
        imagePickerViewController.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 뷰로 이동할 때 네비게이션 바를 다시 보이게 설정
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    // 버튼 테두리 둥글게 적용
    private func setBtnLayout(){
        self.btnCamera.layer.cornerRadius = 15
        self.btnGallery.layer.cornerRadius = 15
        self.btnPdf.layer.cornerRadius = 15
    }
    
    //MARK: Camera Button Action
    @IBAction func btnCameraDidTapped(_ sender: Any) {
        self.log("Camera Button Tapped")
        // imagePicker의 타입 결정
        self.imagePickerViewController.sourceType = .camera // 카메라 실행
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
    //MARK: Gallery Button Action
    @IBAction func btnGalleryDidTapped(_ sender: Any) {
        self.log("Gallery Button Tapped")
        // imagePicker의 타입 결정
        self.imagePickerViewController.sourceType = .photoLibrary // photoLibrary : 갤러리
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
}

// 뷰를 전환하기 위한 NavigationController와, 카메라,갤러리 뷰를 사용하기 위해 ImagePickerControllerDelegate 프로토콜을 채택한다.
extension NoteMakerViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    // 이미지가 선택된 후에, 아래 함수가 호출된다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil) // 이미지 피커 닫기
        // OCR + GPT Generation이 진행중인 동안 indicator를 사용하여 화면에 로딩 띄우는 작업 필요
        // 로딩이 끝난 이후 노트 페이지로 이동 하는 작업 필요(네비게이션으로?)
        if let image = info[.originalImage] as? UIImage {
            // 이미지를 서버로 전송
            FastAPI.shared.makeNoteByImageRequest(image: image){ isSuccess, createdNote in
                if isSuccess{
                    self.createdNote = createdNote
                    // 노트 생성 이후 처리
                    let createdNoteVC = self.stoaryBoard.instantiateViewController(withIdentifier: "CreatedNoteViewController") as! CreatedNoteViewController
                    createdNoteVC.createdNote = self.createdNote // 노트 데이터 전달
                    self.navigationController?.pushViewController(createdNoteVC, animated: true)
                } else {
                    
                }
            }
            
            
        }
    }
    
}

extension NoteMakerViewController {
    private func log(_ message : String){
        print("📌[NoteMakerViewController] \(message)📌")
    }
}
