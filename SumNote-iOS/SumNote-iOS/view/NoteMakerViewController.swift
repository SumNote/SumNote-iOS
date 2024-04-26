//
//  NoteMakerViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/11/17.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

// 사용자가 찍은 사진을 서버로 전송하여 노트 생성 화면으로 이동
class NoteMakerViewController: UIViewController {

    //MARK: layout
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var btnPdf: UIButton!
    
    private let imagePickerViewController = UIImagePickerController()
    
    weak var delegate : NavigationDelegate? // 위임자 선언 => MyNoteTableViewController(메인화면)
    
    var createdNote : CreatedNoteResult?
    
    private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
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
    
    //MARK: PDF Button Action
    
    
    @IBAction func btnPdfDidTapped(_ sender: Any) {
        self.log("PDF Button Tapped")
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }
    
}

// 뷰를 전환하기 위한 NavigationController와, 카메라,갤러리 뷰를 사용하기 위해 ImagePickerControllerDelegate 프로토콜을 채택한다.
extension NoteMakerViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            self.log("No file selected")
            return
        }
        // 파일이 선택되었을 때의 처리 로직
        FastAPI.shared.makeNoteByPdf(pdfURL: url) { success, createdNote in
            if success {
                self.createdNote = createdNote
                // 성공적으로 파일을 업로드하고 처리 완료 후 UI 업데이트
                DispatchQueue.main.async {
                    let createdNoteVC = self.storyBoard.instantiateViewController(withIdentifier: "CreatedNoteViewController") as! CreatedNoteViewController
                    createdNoteVC.createdNote = self.createdNote
                    self.navigationController?.pushViewController(createdNoteVC, animated: true)
                }
            } else {
                self.log("Failed to upload PDF")
            }
        }
    }
    
}

extension NoteMakerViewController {
    private func log(_ message : String){
        print("📌[NoteMakerViewController] \(message)📌")
    }
}


//MARK: PDF File Select
extension NoteMakerViewController : UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        // 파일 선택 이후 api 호출
        FastAPI.shared.makeNoteByPdf(pdfURL : url) { success, createdNote in
            if success {
                self.createdNote = createdNote
                // 노트 생성 이후 처리
                DispatchQueue.main.async {
                    let createdNoteVC = self.storyBoard.instantiateViewController(withIdentifier: "CreatedNoteViewController") as! CreatedNoteViewController
                    createdNoteVC.createdNote = self.createdNote // 노트 데이터 전달
                    self.navigationController?.pushViewController(createdNoteVC, animated: true)
                }
            } else {
                self.log("Failed to upload PDF")
            }
        }
    }
}
