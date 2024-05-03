//
//  QuizPageViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/14.
//

import UIKit


// 사용자가 퀴즈를 풀 수 있도록
class QuizPageViewController: UIPageViewController {
    
    var quizPageList : [QuizPageDto] = [] // 사용자에게 보여줄 데이터 형태
    
    var currentIndex : Int = 0 // 현재 페이지가 몇번째 페이지인지 확인하기 위함
    
    weak var delegater : QuizViewDelegate? // 프로그래스바 및 퀴즈 인덱스 조작용
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self // datasource를 자기 자신으로 지정
        self.delegate = self // delegate 설정 추가
        
        self.log("viewDidLoad quizPageList : \(quizPageList)")
    }
    // 퀴즈 페이지에 정보 할당 후 퀴즈 페이지 리턴
    func getQuizContent(at index : Int) -> QuizContentsViewController? {
        // 유효성 검사
        if index < 0 || index >= quizPageList.count {
            return nil
        }
        // 스토리보드를 통해 퀴즈 페이지 찾기
        let stoaryboard = UIStoryboard(name: "Main", bundle: nil)
        // QuizContentsViewController 찾기
        if let quizContentsVC = stoaryboard.instantiateViewController(withIdentifier: "QuizContentsViewController") as? QuizContentsViewController{
            quizContentsVC.pageIndex = index // 페이지 인덱스 설정
            quizContentsVC.quizPageData = quizPageList[index] // 퀴즈 페이지에 정보 할당
            return quizContentsVC // 정보 할당 완료 후 퀴즈 페이지 리턴
        }
        return nil // 스토리보드 탐색 실패시
        
    }
    
}


//MARK: PageViewController
extension QuizPageViewController : UIPageViewControllerDataSource{
    
    // <<이전>>
    // 우측 -> 좌측 이동시, 이전 페이지 리턴
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let quizContentsVC = viewController as? QuizContentsViewController else {
            return nil
        }
        var index = quizContentsVC.pageIndex
        // 만약 현재 인덱스가 0이라면(시작 페이지라면) -> 페이지 이동 없음
        if index == 0 {
            return nil
        }

        // 그렇지 않다면 이전 인덱스로 이동
        index -= 1
        return getQuizContent(at: index) // 이전 페이지 생성 후 리턴
        
    }
    
    
    // <<이후>>
    // 좌측 -> 우측 이동시, 이전 페이지 리턴
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let quizContentsVC = viewController as? QuizContentsViewController else {
            return nil
        }
        var index = quizContentsVC.pageIndex
        // 마지막 페이지인지 확인
        if index == quizPageList.count - 1 {
            return nil
        }
        // 그렇지 않다면 다음 인덱스로 이동
        index += 1
        return getQuizContent(at: index) // 다음 페이지 생성 후 리턴
    }
    
    
    
}

extension QuizPageViewController: UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentVC = pageViewController.viewControllers?.first as? QuizContentsViewController {
            currentIndex = currentVC.pageIndex // 인덱스 설정
            delegater?.setQuizIndex(index: currentIndex + 1) // 퀴즈 인덱스 설정
        }
    }
}


extension QuizPageViewController {
    private func log(_ message : String){
        print("📌[QuizPageViewController] \(message)📌")
        
    }
}
