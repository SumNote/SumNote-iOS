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
    
    @IBOutlet weak var backBtn : UIImageView! // 뒤로가기 기능을 수행하기 위함
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNoteData() // 노트 데이터 얻어오기
        
        // 뒤로가기 이벤트 정의
        // 탭 제스처 인식기 설정 => 뒤로가기 버튼 사용을 위해
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backBtnTapped))
        backBtn.isUserInteractionEnabled = true // 사용자 상호작용 활성화
        backBtn.addGestureRecognizer(tapGesture)
        
        
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
    
    // 뷰가 실행되고 난 이후 (네비게이션 바 커스텀을 위해 상단 바 숨기기)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // 뷰가 사라질 때 (네비게이션 바 다시 보일 수 있도록)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 뷰로 이동할 때 네비게이션 바를 다시 보이게 설정
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // 서버로부터 데이터 얻어오기
    private func fetchNoteData(){
        let data = ["Page1","Page2","Page3"] // 노트의 각 페이지에 해당하는 내용
        self.noteData = data
    }
    
    // 네비게이션 바 숨기기
    

    // 백 버튼 탭 처리
    // 네비게이션 컨트롤러에서 현재 뷰 컨트롤러 제거
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        print("뒤로가기 클릭됨")
    }
    
}
