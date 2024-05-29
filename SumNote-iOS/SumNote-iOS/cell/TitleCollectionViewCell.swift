//
//  TitleCollectionViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/11.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {

    static let identifier = "TitleCollectionViewCell"
    
    @IBOutlet weak var sumNote: UILabel!
    @IBOutlet weak var developerInformation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sumNote.font = UIFont(name: "Pretendard-Bold", size: 27.0)
        developerInformation.font = UIFont(name: "Pretendard-Bold", size: 27.0)
    }

}
