//
//  NoteSavingDelegate.swift
//  SumNote-iOS
//
//  Created by Choi76 on 4/29/24.
//

import Foundation

// 노트 저장 이후의 동작을 정의
protocol FinishNoteSaveDelegate: AnyObject {
    func shouldCloseAllRelatedViews() // 노트 메이커 화면 앞의 모든 뷰 컨트롤러 종료
}
