//
//  NoteViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/16.
//

import UIKit

class NoteViewController: UIViewController {
    
    var noteData : [String] = [] // 사용자에게 보여줄 데이터
    
    
    @IBOutlet weak var notePageViewContainer: UIView! // 페이지뷰의 컨테이너 역할을 수행
    var notePageViewController : UIPageViewController! // 노트 페이지 뷰
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNoteData() // 노트 데이터 얻어오기
        
        //스토리보드를 사용하여 NotePageViewController 인스턴스화 & 자식 VC로 지정
        if let notePageVC = storyboard?.instantiateViewController(withIdentifier: "NotePageViewController") as? NotePageViewController {
            self.notePageViewController = notePageVC
            self.addChild(notePageVC) // 자식 뷰 컨트롤러로 추가
            self.notePageViewContainer.addSubview(notePageVC.view) // containerView에 뷰 추가
            
            // 노트 데이터 넘기기
            notePageVC.noteData = self.noteData

            // MyPageViewController의 뷰 크기 및 위치 조정(자식으로 지정)
            notePageVC.view.frame = notePageViewContainer.bounds
            notePageVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            notePageVC.didMove(toParent: self)
            
            // 시작 페이지 설정
            if let startingViewController = notePageVC.setNoteContent(at: 0) {
                notePageVC.setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
            }
        }
    }
    
    // 서버로부터 데이터 얻어오기
    private func fetchNoteData(){
        let data = ["Page1","Page2","Page3"] // 노트의 각 페이지에 해당하는 내용
        self.noteData = data
    }
    

    // 백 버튼 탭 처리
    // 네비게이션 컨트롤러에서 현재 뷰 컨트롤러 제거
//    @objc func backBtnTapped() {
//        self.navigationController?.popViewController(animated: true)
//    }
    
}
