//
//  AllNoteCollectionViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/03.
//

import UIKit

// 사용자에게 보여주기 위한 노트 아이템
class AllNoteCollectionViewCell: UICollectionViewCell {
    
    // 식별자
    static let identifier = "AllNoteCollectionViewCell"
    
    // 노트 이미지
    @IBOutlet weak var noteImage: UIImageView!
    // 노트 이름
    @IBOutlet weak var noteTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        noteImage.layer.cornerRadius = 10 // 테두리 둥글게
        noteTitle.preferredMaxLayoutWidth =
            UIScreen.main.bounds.width - 30 // 텍스트 영역 조절(스크린의 전체 가로보다 30만큼 작은크기까지 허용)
    }

}
