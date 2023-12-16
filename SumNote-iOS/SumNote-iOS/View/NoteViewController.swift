//
//  NoteViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/16.
//

import UIKit

class NoteViewController: UIViewController {
    
    var noteData : [String] = [] // 사용자에게 보여줄 데이터
    
    
    var notePageViewController : UIPageViewController! // 노트 페이지 뷰
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 서버로부터 데이터 얻어오기
    private func fetchNoteData(){
        let data = ["Page1","Page2","Page3"] // 노트의 각 페이지에 해당하는 내용
        self.noteData = data
    }
    

    // 백 버튼 탭 처리
    @objc func backBtnTapped() {
        // 네비게이션 컨트롤러에서 현재 뷰 컨트롤러 제거
        self.navigationController?.popViewController(animated: true)
    }
    
}
