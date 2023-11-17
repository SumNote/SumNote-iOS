//
//  MyNoteListCollectionViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/11/17.
//

import UIKit

// MyNote에서 보여줄 나의 전체 노트에 대한 컬렉션 뷰 셀
class MyNoteListCollectionViewCell: UICollectionViewCell {

    //MARK: CollectionView Item Information
    @IBOutlet weak var noteUIImage: UIImageView!
    @IBOutlet weak var noteNameLabel: UILabel!
    @IBOutlet weak var noteGeneratedTime: UILabel!
    
    static let identifier = "MyNoteListCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        noteUIImage.layer.cornerRadius = 20 //테두리 둥글게
    }

}
