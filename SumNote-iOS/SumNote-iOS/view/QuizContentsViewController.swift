//
//  QuizContentsViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/14.
//

import UIKit

// QuizPageViewController에서 사용될 재활용뷰
// 사용자에게 퀴즈 내용을 보여주고, 사용자가 문제를 풀어볼 수 있도록 설계
// 올바른 번호 클릭시 해설 알려주고, 틀린 번호 클릭시 정답과 해설 공개
class QuizContentsViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel! // 문제
    
    @IBOutlet weak var selectionLabel1: UIButton! // 1번 문항
    @IBOutlet weak var selectionLabel2: UIButton! // 2번 문항
    @IBOutlet weak var selectionLabel3: UIButton! // 3번 문항
    @IBOutlet weak var selectionLabel4: UIButton! // 4번 문항
    
    @IBOutlet weak var commentaryLabel: UILabel! // 해설
    
    var quizPageData : QuizPageDto?
    
    var pageIndex: Int = 0 // 페이지 인덱스 프로퍼티
    var question : String? // 질문
    var selections : [QuizSelectionDto]?
    var resultNum : String? // 정답 번호
    var commentary : String? // 해설

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpQuiz()
    }
    
    func setUpQuiz(){
        question = quizPageData?.question
        resultNum = quizPageData?.anwer
        commentary = quizPageData?.commentary
        selections = quizPageData?.selection
        
        questionLabel.text = question
        selectionLabel1.setTitle(selections?[0].selection, for: .normal)
        selectionLabel2.setTitle(selections?[1].selection, for: .normal)
        selectionLabel3.setTitle(selections?[2].selection, for: .normal)
        selectionLabel4.setTitle(selections?[3].selection, for: .normal)
        commentaryLabel.text = commentary
        
    }

}

extension QuizContentsViewController {
    private func log(_ message : String){
        print("📌[QuizContentsViewController] \(message)📌")
    }
}
