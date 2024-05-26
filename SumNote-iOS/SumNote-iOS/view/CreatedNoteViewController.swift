//
//  CreatedNoteViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2024/03/21.
//

import UIKit

// 생성된 노트에 대한 미리보기
// 사용자는 생성된 노트를 확인하고 원한다면 저장, 원하지 않는다면 되돌아간다.
class CreatedNoteViewController: UIViewController {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteContent: UILabel!
    
    var createdNote : CreatedNoteResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitle.font = UIFont(name: "Yeongdeok-Sea", size: 30.0)
        applyBoldEffect(to: noteTitle, fontName: "Yeongdeok-Sea", fontSize: 30.0)
        noteContent.font = UIFont(name: "Yeongdeok-Sea", size: 20.0)
        setNote()
    }
    
    // Bold 효과 적용
    private func applyBoldEffect(to label: UILabel, fontName: String,
                                 fontSize: CGFloat) {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
        shadow.shadowBlurRadius = 1

        let attributes: [NSAttributedString.Key: Any] = [
           .font: UIFont(name: fontName, size: fontSize)!,
           .shadow: shadow
        ]

        label.attributedText = NSAttributedString(string: label.text ?? "", attributes: attributes)
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
    
    
    // 취소 => 되돌아가기
    @IBAction func cancelBtnDidTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.log("cancelBtnDidTapped")
    }
    
    
    @IBAction func saveNoteBtn(_ sender: Any) {
        performSegue(withIdentifier: "saveNote", sender: self)
    }
    
    
    private func setNote(){
        self.noteTitle.text = self.createdNote?.title
        self.noteContent.text = self.createdNote?.summary
    }

}

extension CreatedNoteViewController {
    private func log(_ message : String){
        print("📌[CreatedNoteViewController] \(message)📌")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveNote" {
            guard let saveNoteViewController = segue.destination as? SaveNoteViewController else {
                return
            }
            // 위임자 지정
            saveNoteViewController.finishNoteSaveDelegate = self.navigationController?.viewControllers.first { 
                $0 is NoteMakerViewController } as? NoteMakerViewController
            saveNoteViewController.saveNewNoteDelegate = self
            // 생성된 페이지 정보 전달
            saveNoteViewController.noteTitle = self.noteTitle.text
            saveNoteViewController.noteContent = self.noteContent.text
        } else if segue.identifier == "saveNewNote" { // 새로운 노트에 저장인 경우
            guard let saveNewNoteViewController = segue.destination as? SaveNewNoteViewController else {
                return
            }
            // 정보 전달
            saveNewNoteViewController.finishNoteSaveDelegate = self.navigationController?.viewControllers.first { $0 is NoteMakerViewController } as? NoteMakerViewController
            saveNewNoteViewController.noteTitle = self.noteTitle.text
            saveNewNoteViewController.noteContent = self.noteContent.text
        }
    }
}

extension CreatedNoteViewController : SaveNewNoteDelegate {
    
    func showSaveNewNoteModal() {
        self.log("showSaveNewNoteModal")
        performSegue(withIdentifier: "saveNewNote", sender: self)
    }
}
