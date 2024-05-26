//
//  EmptyQuizCollectionViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 5/21/24.
//

import UIKit

class EmptyQuizCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EmptyQuizCollectionViewCell"

    @IBOutlet weak var announce: UILabel!
    @IBOutlet weak var emptyCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        emptyCellView.layer.cornerRadius = 25
        announce.font = UIFont(name: "Pretendard-ExtraLight", size: 15.0)
    }

}
