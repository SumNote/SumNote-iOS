//
//  ChangeNoteTitleViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 5/1/24.
//

import UIKit

class ChangeNoteTitleViewController: UIViewController {

    @IBOutlet weak var changeNoteTitleEditText: UITextField!
    @IBOutlet weak var changeNoteTitleViewBtn: UIView!
    @IBOutlet weak var dialogUIView: UIView!
    @IBOutlet weak var dialogCenterYConstraint: NSLayoutConstraint!
    
    
    var noteId : Int?
    weak var changeNotTitleDelegate : ChangeNoteTitleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.log("viewDidLoad noteId : \(String(describing: noteId))")
        let changeNoteTitleGesture = UITapGestureRecognizer(target: self, action: #selector(changeNoteTitle))
        changeNoteTitleViewBtn.addGestureRecognizer(changeNoteTitleGesture)
        
        // 키보드 동작시, 뷰의 높이가 높아져야함(동적 오토레이아웃)
        changeNoteTitleEditText.addTarget(self, action: #selector(startEditing), for: .editingDidBegin)
        changeNoteTitleEditText.addTarget(self, action: #selector(endEditing), for: .editingDidEnd)
    
        // 뷰 전체에 대한 탭 제스처 인식기 추가
        let keyBoardTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        keyBoardTapGesture.cancelsTouchesInView = false
        dialogUIView.addGestureRecognizer(keyBoardTapGesture)
        
        let dismissDialogTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissDialog))
        view.addGestureRecognizer(dismissDialogTapGesture)
        
    }
    
    @objc func dismissDialog(sender : UITapGestureRecognizer){
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
    
    
    @objc func changeNoteTitle(){
        let newTitle = self.changeNoteTitleEditText.text
        let changeNoteParameter = ChangeNoteParameter(changeTitle: newTitle)
        SpringAPIService.shared.changeNoteNameRequest(noteId: self.noteId!, changeNoteParameter: changeNoteParameter){ isSuccess in
            if isSuccess{
                self.log("changeNoteTitle Success")
                self.changeNotTitleDelegate?.changeNoteTitle(newTitle: newTitle!)
                self.dismiss(animated: false) // 다이얼로그 종료
            } else {
                self.log("changeNoteTitle Fail!")
            }
            
        }
        
    }
}

extension ChangeNoteTitleViewController {
    private func log(_ message : String){
        print("📌[ChangeNoteTitleViewController] \(message)📌")
    }
}
