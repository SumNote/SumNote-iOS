//
//  NoteContentsViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/16.
//

import UIKit

class NoteContentsViewController: UIViewController {
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var pageContent: UILabel!
    
    var pageIndex: Int = 0 // 페이지 인덱스 프로퍼티
    var notePageData : NotePagesDto? // 현재 페이지 정보
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPageContent()
        self.log("notePageData : \(notePageData!)")
    }
    
    private func setPageContent(){
        self.pageTitle.text = notePageData?.title
        self.pageContent.text = notePageData?.content
    }
}

extension NoteContentsViewController {
    private func log(_ message : String){
        print("📌[NoteContentsViewController] \(message)📌")
    }
}
