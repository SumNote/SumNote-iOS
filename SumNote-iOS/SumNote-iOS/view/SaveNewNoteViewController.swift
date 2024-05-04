//
//  SaveNewNoteViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 4/29/24.
//

import UIKit

class SaveNewNoteViewController: UIViewController {
    
    // 새롭게 저장할 노트의 이름
    @IBOutlet weak var newNoteTitle: UITextField!
    
    @IBOutlet weak var doneBtnView: UIView! // 완료버튼으로 사용하기 위한 뷰
    
    var noteTitle : String?
    var noteContent : String?
    weak var finishNoteSaveDelegate: FinishNoteSaveDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneBtnTapGesture = UITapGestureRecognizer(target: self, action: #selector(saveByNewNote))
        doneBtnView.addGestureRecognizer(doneBtnTapGesture)
        
    }
    
    @objc private func saveByNewNote(_ sender: UITapGestureRecognizer){
        
        // 저장할 데이터 형성
        let newNote = noteDto(title: newNoteTitle.text!)
        let newNotePage = SaveNotePageDto(title: noteTitle!, content: noteContent!)
        let createNoteDto = CreateNoteDto(note : newNote, notePages : [newNotePage])
        // 새로운 노트 저장 API 호출
        SpringAPIService.shared.savePageToNewNoteRequest(newNote: createNoteDto){ isSuccess in
            if isSuccess{
                // 성공 토스트 뷰 띄우기
                
                self.log("saveByNewNote Success!")
                // 초기 화면으로 되돌아가기
                self.dismiss(animated: false){
                    self.finishNoteSaveDelegate?.shouldCloseAllRelatedViews()
                }
                
            } else {
                // 실패시 로직 작성 필요
                self.log("saveByNewNote Fail!")
            }
            
        }
        
        
    }

}

extension SaveNewNoteViewController {
    private func log(_ message : String){
        print("📌[SaveNewNoteViewController] \(message)📌")
    }
}
