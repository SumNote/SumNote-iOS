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
    
    @IBOutlet weak var dialogUIView: UIView!
    
    var noteTitle : String?
    var noteContent : String?
    weak var finishNoteSaveDelegate: FinishNoteSaveDelegate?
    
    @IBOutlet weak var dialogCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneBtnTapGesture = UITapGestureRecognizer(target: self, action: #selector(saveByNewNote))
        doneBtnView.addGestureRecognizer(doneBtnTapGesture)
        
        // 키보드 동작시, 뷰의 높이가 높아져야함(동적 오토레이아웃)
        newNoteTitle.addTarget(self, action: #selector(startEditing), for: .editingDidBegin)
        newNoteTitle.addTarget(self, action: #selector(endEditing), for: .editingDidEnd)
    
        
        // 뷰 전체에 대한 탭 제스처 인식기 추가
        let keyBoardTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        keyBoardTapGesture.cancelsTouchesInView = false
        dialogUIView.addGestureRecognizer(keyBoardTapGesture)
        
        let closeDialogTapGesture = UITapGestureRecognizer(target: self, action: #selector(closeDialog))
        view.addGestureRecognizer(closeDialogTapGesture)
        
    }
    
    @objc func closeDialog(sender : UITapGestureRecognizer){
        self.dismiss(animated: true)
    }
    
    // 키보드가 나타나면 다이얼로그를 위로 이동
    @objc func startEditing(sender : UITextField){
        dialogCenterYConstraint.constant -= 50
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // 키보드가 사라지면 다이얼로그를 아래로 이동
    @objc func endEditing(sender : UITextField){
        dialogCenterYConstraint.constant += 50
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // 다른 영역 클릭시 키보드 종료
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc private func saveByNewNote(_ sender: UITapGestureRecognizer){
        
        // 저장할 데이터 형성
        let newNote = noteDto(title: newNoteTitle.text!)
        let newNotePage = SaveNotePageDto(title: noteTitle!, content: noteContent!)
        let createNoteDto = CreateNoteDto(note : newNote, notePages : [newNotePage])
        // 새로운 노트 저장 API 호출
        SpringAPIService.shared.savePageToNewNoteRequest(newNote: createNoteDto){ isSuccess in
            if isSuccess{
                // 성공 토스트 뷰 띄우기"
                ToastMessage.shared.showToast(message: "노트가 생성되었습니다.", fontSize: 14.0, view: self.view)
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
