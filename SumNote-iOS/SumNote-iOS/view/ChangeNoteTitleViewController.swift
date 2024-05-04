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
    
    var noteId : Int?
    weak var changeNotTitleDelegate : ChangeNoteTitleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.log("viewDidLoad noteId : \(String(describing: noteId))")
        let changeNoteTitleGesture = UITapGestureRecognizer(target: self, action: #selector(changeNoteTitle))
        changeNoteTitleViewBtn.addGestureRecognizer(changeNoteTitleGesture)
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
