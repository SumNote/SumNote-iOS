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
    var answerIndex : Int!
    var gradeFinish : Bool = false // 채점 상태
    
    var selectionButtonLabelList : [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpQuiz()
    }
    
    func setUpQuiz() {
        question = quizPageData?.question
        resultNum = quizPageData?.answer
        commentary = quizPageData?.commentary
        selections = quizPageData?.selection

        if let answer = resultNum, let num = Int(answer) {
            self.answerIndex = num - 1
        }

        selectionButtonLabelList.append(selectionLabel1)
        selectionButtonLabelList.append(selectionLabel2)
        selectionButtonLabelList.append(selectionLabel3)
        selectionButtonLabelList.append(selectionLabel4)

        questionLabel.text = question
        for (i, selectionLabel) in selectionButtonLabelList.enumerated() {
            selectionLabel.setTitle(selections?[i].selection, for: .normal)
            selectionLabel.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 16.0)
            selectionLabel.addTarget(self, action: #selector(grading), for: .touchUpInside)
            selectionLabel.tag = i // 버튼에 태그 설정
        }

        commentaryLabel.text = commentary
        commentaryLabel.isHidden = true // 초기엔 정답 안보임
        
        questionLabel.font = UIFont(name: "Pretendard-Medium", size: 20.0)
        commentaryLabel.font = UIFont(name: "Pretendard-Regular", size: 17.0)
    }

    // 채점하기
    @objc func grading(sender: UIButton) {
        if gradeFinish == false{
            if sender.tag == self.answerIndex {
                self.log("grading result -> Correct!")
                ToastMessage.shared.showToast(message: "정답입니다!", fontSize: 14.0, view: self.view)
            } else {
                self.log("grading result -> Wrong!")
                ToastMessage.shared.showToast(message: "틀렸습니다!", fontSize: 14.0, view: self.view)
                let wrongAnswerLabel = selectionButtonLabelList[sender.tag]
                wrongAnswerLabel.borderColor = .red
                wrongAnswerLabel.borderWidth = 5
                wrongAnswerLabel.cornerRadius = 10
            }
            let answerLabel = selectionButtonLabelList[self.answerIndex]
            answerLabel.borderColor = UIColor(named: "green")
            answerLabel.borderWidth = 5
            answerLabel.cornerRadius = 10
            
            commentaryLabel.isHidden = false
            gradeFinish = true // 채점 완료 => 한번 풀은 상태에서는 다시 풀기 불가능
        }
    }


}

extension QuizContentsViewController {
    private func log(_ message : String){
        print("📌[QuizContentsViewController] \(message)📌")
    }
}
