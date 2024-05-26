//
//  DeveloperInfoCollectionViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/11.
//

import UIKit

class DeveloperInfoCollectionViewCell: UICollectionViewCell {

    static let identifier = "DeveloperInfoCollectionViewCell"
    
    @IBOutlet weak var devImage: UIImageView!
    @IBOutlet weak var devName: UILabel!
    @IBOutlet weak var devEmail: UILabel!
    @IBOutlet weak var devAff: UILabel!
    @IBOutlet weak var role1: UILabel!
    @IBOutlet weak var role2: UILabel!
    @IBOutlet weak var role3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        devName.font = UIFont(name: "Pretendard-Bold", size: 25.0)
        devAff.font = UIFont(name: "Pretendard-ExtraLight", size: 20.0)
        devEmail.font = UIFont(name: "Pretendard-Medium", size: 15.0)
        role1.font = UIFont(name: "Pretendard-Medium", size: 16.0)
        role2.font = UIFont(name: "Pretendard-Medium", size: 16.0)
        role3.font = UIFont(name: "Pretendard-Medium", size: 16.0)
    }

}
