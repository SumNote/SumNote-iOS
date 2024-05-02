//
//  NotePageViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/13.
//

import UIKit


// 노트 화면에 해당
// 좌우 슬라이드를 통해 노트의 내용을 보며 학습 가능
class NotePageViewController: UIPageViewController {
    
    var pageData : [NotePagesDto] = [] // 노트 페이지 정보
    
    var currentIndex : Int = 0 // 현재 페이지가 몇번째 페이지인지 확인하기 위함
    
    weak var pageCheckDelegate : NotePageCheckDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self // for UIPageViewController
        
        // 정보 수신 확인
        self.log("viewDidLoad : \(pageData)")
    }
    
    // 노트의 페이지에 정보 할당 후 노트 페이지 리턴
    func setNoteContent(at index : Int) -> NoteContentsViewController? {
        // 유효성 검사
        if index < 0 || index >= pageData.count {
            return nil
        }
        // 스토리보드를 통해 퀴즈 페이지 찾기
        let stoaryboard = UIStoryboard(name: "Main", bundle: nil)
        // NoteContentsViewController 찾기
        if let noteContentsVC = stoaryboard.instantiateViewController(withIdentifier: "NoteContentsViewController") as? NoteContentsViewController{
            // 노트 페이지에 정보 할당
            noteContentsVC.notePageData = pageData[index]
            // 노트 페이지의 인덱스 설정
            noteContentsVC.pageIndex = index // 페이지 인덱스 설정
            // 정보 할당 완료 후 퀴즈 페이지 리턴
            return noteContentsVC
        }
        return nil // 스토리보드 탐색 실패시
        
    }
    
    
}

// MARK: - DataSource

extension NotePageViewController: UIPageViewControllerDataSource {

    // 우측 -> 좌측으로 슬라이드 제스처 발생시
    // 이전 뷰 컨트롤러를 리턴
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let noteContentsVC = viewController as? NoteContentsViewController else {
            return nil
        }
        var index = noteContentsVC.pageIndex
        // 만약 현재 인덱스가 0이라면(시작 페이지라면) -> 페이지 이동 없음
        if index == 0 {
            return nil
        }

        // 그렇지 않다면 이전 인덱스로 이동
        index -= 1
        pageCheckDelegate?.getCurrentNotePage(index: index)
        return setNoteContent(at: index) // 이전 페이지 생성 후 리턴
        
    }

    // 좌측 -> 우측으로 슬라이드 제스처 발생시
    // 다음 뷰 컨트롤러를 리턴
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let noteContentsVC = viewController as? NoteContentsViewController else {
            return nil
        }
        var index = noteContentsVC.pageIndex
        // 마지막 페이지인지 확인
        if index == pageData.count - 1 {
            return nil
        }
        // 그렇지 않다면 다음 인덱스로 이동
        index += 1
        pageCheckDelegate?.getCurrentNotePage(index: index)
        return setNoteContent(at: index) // 다음 페이지 생성 후 리턴
        
    }


}

extension NotePageViewController{
    private func log(_ message : String){
        print("📌[NotePageViewController] \(message)📌")
    }
}
