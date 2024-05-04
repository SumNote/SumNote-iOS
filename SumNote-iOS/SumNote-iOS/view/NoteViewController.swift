//
//  NoteViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/16.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var notePageViewContainer: UIView! // 페이지뷰의 컨테이너 역할 수행
    @IBOutlet weak var backBtn : UIImageView! // 뒤로가기 기능을 수행하기 위함
    @IBOutlet weak var makeQuizBtn: UIButton!
    
    var userNotePages : UserNotePage!
    var pageData : [NotePagesDto] = []
    var notePageViewController : UIPageViewController! // 노트 페이지 뷰
    
    // 현재 사용자가 pageData의 몇번 째 노트를 보고 있는지 관측하기 위함
    var currIndex : Int = 0 // 디폴트는 0번째 페이지
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNote() // 노트 제목 설정 및 페이지 할당
        self.log("viewDidLoad userNotePage : \(String(describing: pageData))")
        setupBackButton() // 뒤로가기 이벤트 정의
        setpriorityButton() // 메뉴 버튼 설정
    }
    
    private func setupNote(){
        self.noteTitle.text = userNotePages.note?.title // 노트 제목 설정
        self.pageData = userNotePages.notePages!
        setupNotePageViewController() // 데이터 할당 이후 뷰 컨트롤러 설정
    }
    
    
    // 뷰가 실행되고 난 이후 (네비게이션 바 커스텀을 위해 상단 바 숨기기)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // 다른 뷰로 이동할 때 네비게이션 바를 다시 보이게 설정
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // 풀 다운 메뉴 활성화
    @IBAction func makeQuizPullDownBtnDidTapped(_ sender: UIButton) {
        setpriorityButton()
    }
    
    func setpriorityButton() {
        makeQuizBtn.menu = UIMenu(children: [
            UIAction(title: "문제 생성", state: .off, handler: createQuizHandler),
            UIAction(title: "제목 수정", state: .off, handler: changeNoteNameHandler),
            UIAction(title: "노트 삭제", state: .off, handler: deleteNote)
        ])
        makeQuizBtn.showsMenuAsPrimaryAction = true
        makeQuizBtn.changesSelectionAsPrimaryAction = true
    }
    
    
    // 문제 생성
    func createQuizHandler(action : UIAction){
        self.log("call createQuizHandler")
        
        let currNoteContent = pageData[self.currIndex]
        let currNoteId = userNotePages.note?.noteId!
        let currNoteTitle = userNotePages.note?.title!
        let currNoteText = "[\(currNoteContent.title!)]\n\(currNoteContent.content!)"
        self.log("createQuizHandler : \(currNoteText)")
        
        // 커스텀 인디케이터 시작
        
        FastAPIService.shared.makeQuizRequest(noteText: currNoteText){ isSuccess,quizResponseDto in
            if isSuccess {
                self.log("createQuizHandler Success! \(String(describing: quizResponseDto))")	
                let quizParameter = CreateQuizRequestParameter(noteId: currNoteId, title: "\(currNoteTitle!)의 퀴즈",quiz: quizResponseDto?.data!)
                // 스프링에 저장 요청
                SpringAPIService.shared.createQuizDocRequest(parameter: quizParameter){ isSuccess in
                    if isSuccess{
                        self.log("createQuizDocRequest Success")
                        // 커스텀 인디케이터 종료 => 퀴즈가 생성되었습니다.
                        // self.dismiss(animated: false) // 성공이후 메인화면으로 되돌아가기
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.log("createQuizDocReqeust Fail")
                        // 예외처리 필요
                    }
                }
            } else {
                self.log("createQuizHandler Fail!")
            }
            
        }
    }
    
    // 노트 제목 수정
    func changeNoteNameHandler(action : UIAction){
        // 노트 제목 변경 다이얼로그 띄우기
        performSegue(withIdentifier: "changeNoteTitle" , sender: self)
    }
    
    // 노트 삭제
    func deleteNote(action : UIAction){
        print("노트 삭제")
    }
    
    
    
    
    private func setupBackButton() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backBtnTapped))
        backBtn.isUserInteractionEnabled = true
        backBtn.addGestureRecognizer(tapGesture)
    }
    
    private func setupNotePageViewController() {
        //스토리보드를 사용하여 NotePageViewController 인스턴스화 & 자식 VC로 지정
        if let notePageVC = self.storyboard?.instantiateViewController(withIdentifier: "NotePageViewController") as? NotePageViewController {
            self.notePageViewController = notePageVC
            notePageVC.pageCheckDelegate = self
            
            notePageVC.pageData = self.pageData // 페이지 데이터 넘기기
            self.notePageViewContainer.addSubview(notePageVC.view) // containerView에 뷰 추가
            self.addChild(notePageVC) // 자식 뷰 컨트롤러로 추가
            
            // MyPageViewController의 뷰 크기 및 위치 조정(자식으로 지정)
            notePageVC.view.frame = self.notePageViewContainer.bounds
            notePageVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            notePageVC.didMove(toParent: self)
            
            // 시작 페이지 설정
            if let startingViewController = notePageVC.setNoteContent(at: 0) {
                notePageVC.setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
            }
        }
    }
    

    // 백 버튼 탭 처리
    // 네비게이션 컨트롤러에서 현재 뷰 컨트롤러 제거
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        print("뒤로가기 클릭됨")
    }
    
}


extension NoteViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeNoteTitle"{
            guard let changeNoteTitleViewController = segue.destination as? ChangeNoteTitleViewController else {
                return
            }
            let noteId = userNotePages.note?.noteId
            changeNoteTitleViewController.noteId = noteId // 노트 타이틀 변경을 위해
            changeNoteTitleViewController.changeNotTitleDelegate = self
        }
    }
}

extension NoteViewController {
    private func log(_ message : String){
        print("📌[NoteViewController] \(message)📌")
    }
}

extension NoteViewController : ChangeNoteTitleDelegate{
    // 현재 뷰 컨트롤러에서 보여지는 노트 이름 변경
    func changeNoteTitle(newTitle : String){
        DispatchQueue.main.async {
            self.noteTitle.text = newTitle
        }
    }
}

extension NoteViewController : NotePageCheckDelegate {
    func getCurrentNotePage(index: Int) {
        self.currIndex = index
        self.log("currentIndex : \(index)")
    }
}
