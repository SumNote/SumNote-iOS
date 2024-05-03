//
//  NoteTableViewCellDelegate.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/06.
//

// MyNoteViewController에 연결된 Navigation Controller를 사용하기 위한 프로토콜
protocol NavigationDelegate: AnyObject {
    func didTapGoAllNoteButton() // 노트 테이블뷰 셀에서, 전체 노트 화면으로의 이동을 담당
    func didTapGoAllQuizButton() // 퀴즈 테이블뷰 셀에서, 전체 퀴즈 화면으로의 이동을 담당
    
    // => 추후 아이디를 넘기는 로직 작성 필요 => 아이디를 전달받아, 서버에서 데이터를 요청해야함
    func didTappedNoteCell(_ userNotePage : UserNotePage) // 노트 셀(미리보기), 전체 노트 셀 클릭시 노트 페이지로의 이동을 담당
    func didTappedQuizCell(quizPageData: QuizPageDataDto, quizTitle : String)  // 퀴즈 셀(미리보기), 전체 퀴즈 셀 클릭시 퀴즈 페이지로의 이동을 담당
}
