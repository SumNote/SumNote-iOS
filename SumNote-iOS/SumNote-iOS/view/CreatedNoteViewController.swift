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

        setNote()
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
    
    private func setNote(){
        self.noteTitle.text = self.createdNote?.title
        self.noteContent.text = self.createdNote?.summary
    }

}

extension CreatedNoteViewController {
    private func log(_ message : String){
        print("📌[CreatedNoteViewController] \(message)📌")
    }
}
