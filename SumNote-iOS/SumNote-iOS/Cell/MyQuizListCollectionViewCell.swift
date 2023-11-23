//
//  MyQuizListCollectionViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/11/23.
//

import UIKit

// 사용자가 생성한 모든 퀴즈 목록들
class MyQuizListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var quizUIImage: UIImageView! //배경사진
    @IBOutlet weak var quizTitleLabel: UILabel! //퀴즈 타이틀
    @IBOutlet weak var quizGenTimeLabel: UILabel! //생성시간
    
    static let identifier = "MyQuizListCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        quizUIImage.layer.cornerRadius = 15 //테두리 둥글게
    }

}
