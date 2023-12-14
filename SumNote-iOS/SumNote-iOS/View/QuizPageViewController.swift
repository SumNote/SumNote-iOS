//
//  QuizPageViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/14.
//

import UIKit


// 사용자가 퀴즈를 풀 수 있도록
class QuizPageViewController: UIPageViewController {

    var quizData : [String] = [] // 사용자에게 보여줄 데이터형태
    
    var currentIndex : Int = 0 // 현재 페이지가 몇번째 페이지인지 확인하기 위함
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self // datasource를 자기 자신으로 지정
        
        
        // 시작 페이지 지정 UIPageViewController의 setViewController함수 사용
        if let startingViewController = getQuizContent(at: 0) { // 0번째 값으로 페이지 시작
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }

    // 서버로부터 퀴즈 정보 얻어오기
    func fetchQuizData(){
        var data = ["Quiz1","Quiz2","Quiz3"] // 퀴즈로 제공할 정보 배열(테스트용)
        self.quizData = data
    }
    
    
    // 퀴즈 페이지에 정보 할당 후 퀴즈 페이지 리턴
    func getQuizContent(at index : Int) -> QuizPageViewController? {
        // 유효성 검사
        if index < 0 || index >= quizData.count {
            return nil
        }
        // 스토리보드를 통해 퀴즈 페이지 찾기
        let stoaryboard = UIStoryboard(name: "Main", bundle: nil)
        // QuizContentsViewController 찾기
        if let quizContentsVC = stoaryboard.instantiateViewController(withIdentifier: "QuizContentsViewController") as? QuizPageViewController{
            // 퀴즈 페이지에 정보 할당
            // 퀴즈 페이지의 인덱스 설정 필요?
            
            // 정보 할당 완료 후 퀴즈 페이지 리턴
            return quizContentsVC
        }
        return nil // 스토리보드 탐색 실패시
        
    }
    
}


//MARK: PageViewController
extension QuizPageViewController : UIPageViewControllerDataSource{
    
    // <<이전>>
    // 우측 -> 좌측 이동시, 이전 페이지 리턴
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 만약 현재 인덱스가 0이라면(시작 페이지라면) -> 페이지 이동 없음
        if currentIndex == 0 {
            return nil
        }

        // 그렇지 않다면 이전 인덱스로 이동
        currentIndex -= 1
        return getQuizContent(at: currentIndex) // 이전 페이지 생성 후 리턴
        
    }
    
    
    // <<이후>>
    // 좌측 -> 우측 이동시, 이전 페이지 리턴
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // 마지막 페이지인지 확인
        if currentIndex == quizData.count {
            return nil
        }
        // 그렇지 않다면 다음 인덱스로 이동
        currentIndex += 1
        return getQuizContent(at: currentIndex) // 다음 페이지 생성 후 리턴
    }
    
    
    
}
