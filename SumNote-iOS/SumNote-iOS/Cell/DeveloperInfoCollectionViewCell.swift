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
    
    @IBOutlet weak var role1: UILabel!
    @IBOutlet weak var role2: UILabel!
    @IBOutlet weak var role3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
