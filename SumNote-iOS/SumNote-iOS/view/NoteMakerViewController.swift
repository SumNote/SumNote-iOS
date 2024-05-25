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

    @IBOutlet weak var btnCamera: UIView!
    @IBOutlet weak var btnPdf: UIView!
    @IBOutlet weak var btnGallery: UIView!
    
    private let imagePickerViewController = UIImagePickerController()
    
    weak var delegate : NavigationDelegate?
    
    var createdNote : CreatedNoteResult?
    
    private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerViewController.delegate = self
        
        // CameraViewBtn DidTappedGesture
        let cameraViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(btnCameraDidTapped))
        btnCamera.addGestureRecognizer(cameraViewTapGesture)
        
        // PdfViewBtn DidTappedGesture
        let pdfViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(btnPdfDidTapped))
        btnPdf.addGestureRecognizer(pdfViewTapGesture)
        
        // GalleryViewBtn DidTappedGesture
        let galleryViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(btnGalleryDidTapped))
        btnGallery.addGestureRecognizer(galleryViewTapGesture)
        
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

    
    // MARK: Camera Button Action
    @objc func btnCameraDidTapped(Sender : UITapGestureRecognizer){
        self.log("Camera Button Tapped")
        // imagePicker의 타입 결정
        self.imagePickerViewController.sourceType = .camera // 카메라 실행
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
    // MARK: Gallery Button Action
    @objc func btnGalleryDidTapped(sender : UITapGestureRecognizer){
        self.log("Gallery Button Tapped")
        // imagePicker의 타입 결정
        self.imagePickerViewController.sourceType = .photoLibrary // photoLibrary : 갤러리
        self.present(imagePickerViewController, animated: true, completion: nil)
    }
    
    // MARK: PDF Button Action
    @objc func btnPdfDidTapped(sender : UITapGestureRecognizer){
        self.log("PDF Button Tapped")
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf], asCopy: true)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }
    
}

// 뷰를 전환하기 위한 NavigationController와, 카메라,갤러리 뷰를 사용하기 위해 ImagePickerControllerDelegate 프로토콜을 채택한다.
extension NoteMakerViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIDocumentPickerDelegate{
    
    //MARK: PDF File Select
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            self.log("No file selected")
            return
        }
        FastAPIService.shared.makeNoteByPdf(pdfURL: url) { success, createdNote in
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
    
    //MARK: Image Select (Gallery & Camera)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택된 이미지를 얻기
        guard let selectedImage = info[.originalImage] as? UIImage else {
            self.log("No image was selected")
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        FastAPIService.shared.makeNoteByImageRequest(image: selectedImage) { success, createdNote in
            if success {
                self.createdNote = createdNote
                DispatchQueue.main.async {
                    let createdNoteVC = self.storyBoard.instantiateViewController(withIdentifier: "CreatedNoteViewController") as! CreatedNoteViewController
                    createdNoteVC.createdNote = self.createdNote
                    self.navigationController?.pushViewController(createdNoteVC, animated: true)
                }
            } else {
                self.log("Failed to upload image")
            }
        }
            
        // 이미지 선택 후 picker 닫기
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension NoteMakerViewController {
    private func log(_ message : String){
        print("📌[NoteMakerViewController] \(message)📌")
    }
}

extension NoteMakerViewController: FinishNoteSaveDelegate {
    func shouldCloseAllRelatedViews() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
