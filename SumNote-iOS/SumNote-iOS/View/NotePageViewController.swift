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

    // 페이지 뷰를 통해 넘겨줄 화면들을에 대한 배열
    private var pages = [UIViewController]()
    // 시작 페이지 번호
    private var initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 페이지에 값 할당
    private func setupPages(){
        //
    }

}
