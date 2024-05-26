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
        self.pageTitle.font = UIFont(name: "Yeongdeok-Sea", size: 30.0)
        self.applyBoldEffect(to: pageTitle, fontName: "Yeongdeok-Sea", fontSize: 30.0)
        
        self.pageContent.text = notePageData?.content
        self.pageContent.font = UIFont(name: "Yeongdeok-Sea", size: 20.0)
    }
    
    // Bold 효과 적용
    private func applyBoldEffect(to label: UILabel, fontName: String,
                                 fontSize: CGFloat) {
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
        shadow.shadowBlurRadius = 1

        let attributes: [NSAttributedString.Key: Any] = [
           .font: UIFont(name: fontName, size: fontSize)!,
           .shadow: shadow
        ]

        label.attributedText = NSAttributedString(string: label.text ?? "", attributes: attributes)
    }
}

extension NoteContentsViewController {
    private func log(_ message : String){
        print("📌[NoteContentsViewController] \(message)📌")
    }
}
