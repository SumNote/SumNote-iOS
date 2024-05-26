//
//  AllNoteTableViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/07.
//

import UIKit

class AllNoteTableViewCell: UITableViewCell {

    static let identifier = "AllNoteTableViewCell"
    
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteGenDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        noteTitle.font = UIFont(name: "Pretendard-Bold", size: 18.0)
        noteGenDate.font = UIFont(name: "Pretendard-ExtraLight", size: 13.0)
        noteImage.layer.cornerRadius = 10 // 테두리 둥글게
    }

    
    // 선택시 동작
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
