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

    // 페이지 뷰를 통해 넘겨줄 화면들에 대한 배열
    private var pages = [UIViewController]()
    // 시작 페이지 번호 => 화면 이동시 사용
    private var initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("NotePageViewController Called")
        setupPages() // 데이터 설정(더미데이터 사용)
        setupUI() // dataSource 설정
    }
    
    // 페이지 배열에 값 할당 => 서버로부터 데이터 얻어와서 할당하는 과정 필요
    private func setupPages(){
        print("NotePageViewController : setupPages()")
        let page1 = PageContentsViewController(titleString: "#1 타이틀 #1")
        let page2 = PageContentsViewController(titleString: "#2 타이틀 #2")
        let page3 = PageContentsViewController(titleString: "#3 타이틀 #3")
 
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        print("NotePageViewController : pageSize \(pages.count)")
    }
    
    
    // dataSource 설정
    private func setupUI() {
       print("NotePageViewController : setupUI()")
       self.dataSource = self
       // UIPageViewController에서 처음 보여질 뷰컨트롤러 설정 (첫 번째 page)
       self.setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }

}

// MARK: - DataSource

extension NotePageViewController: UIPageViewControllerDataSource {
    
    // 우측 -> 좌측으로 슬라이드 제스처 발생시
    // 이전 뷰 컨트롤러를 리턴
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 현재 ViewController의 인덱스 구하기
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        guard currentIndex > 0 else { return nil }
        print("우측 -> 좌측 현재 페이지 : \(currentIndex)" )
        return pages[currentIndex - 1] // 이전 인덱스의 ViewController 리턴
    }
    
    // 좌측 - 우측으로 슬라이드 제스처 발생시
    // 다음 뷰 컨트롤러를 리턴
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // 현재 ViewController의 인덱스 구하기
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        guard currentIndex < (pages.count - 1) else { return nil }
        print("좌측 -> 우측 현재 페이지 : \(currentIndex)" )
        return pages[currentIndex + 1]
    }
    
    
}
