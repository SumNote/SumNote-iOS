//
//  SaveNewNoteDelegate.swift
//  SumNote-iOS
//
//  Created by Choi76 on 4/29/24.
//

import Foundation

// 새로운 노트에 저장할 때에 대한 Delegate
protocol SaveNewNoteDelegate : AnyObject {
    func showSaveNewNoteModal()
}
