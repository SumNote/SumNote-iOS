//
//  NoteTableViewCellDelegate.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/06.
//
protocol NoteTableViewCellDelegate: AnyObject {
    func didTapGoAllNoteButton() // 노트 테이블뷰 셀에서, 전체 노트 화면으로의 이동을 담당
}
