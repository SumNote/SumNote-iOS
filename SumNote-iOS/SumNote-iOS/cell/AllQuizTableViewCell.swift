//
//  AllQuizTableViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/07.
//

import UIKit

class AllQuizTableViewCell: UITableViewCell {

    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var quizGenDate: UILabel!
    @IBOutlet weak var quizTitle: UILabel!
    
    static let identifier = "AllQuizTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        quizTitle.font = UIFont(name: "Pretendard-Bold", size: 18.0)
        quizGenDate.font = UIFont(name: "Pretendard-ExtraLight", size: 13.0)
        quizImage.layer.cornerRadius = 10
    }

    
    // 선택시 동작
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
