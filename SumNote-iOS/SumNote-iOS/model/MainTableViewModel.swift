//
//  MainTableViewModel.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/05.
//


// 필요한 데이터
// 테이블 뷰 제목(최근 노트 보기, 최근 푼 문제 보기),
struct MainTableViewModel {
    private let title : String
    private let type : MainTableViewType // 기본 값 노트로 설정
    init(title: String, type: MainTableViewType){
        self.title = title
        self.type = type
    }
}

// 테이블 뷰에서 이 속성을 확인하고, 어떤 데이터를 서버로부터 요청하것인지 선택
enum MainTableViewType{
    case NOTE
    case QUIZ
}
