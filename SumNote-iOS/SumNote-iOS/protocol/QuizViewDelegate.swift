//
//  QuizViewDelegate.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/16.
//
protocol QuizViewDelegate: AnyObject {
    func setProgressBar(index : Int)// 프로그래스 바 조작용
    func setQuizIndex(index : Int)// 문제 인덱스 조작용
}
