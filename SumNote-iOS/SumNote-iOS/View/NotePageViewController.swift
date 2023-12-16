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

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // 노트 데이터 설정
    
    
}

// MARK: - DataSource

//extension NotePageViewController: UIPageViewControllerDataSource {
//
//    // 우측 -> 좌측으로 슬라이드 제스처 발생시
//    // 이전 뷰 컨트롤러를 리턴
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//
//    }
//
//    // 좌측 - 우측으로 슬라이드 제스처 발생시
//    // 다음 뷰 컨트롤러를 리턴
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//
//    }
//
//
//}
