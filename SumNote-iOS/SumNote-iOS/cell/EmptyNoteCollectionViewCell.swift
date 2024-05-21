//
//  EmptyNoteCollectionViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 5/21/24.
//

import UIKit

class EmptyNoteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var alertView: UIView!
    static let identifier = "EmptyNoteCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        alertView.layer.cornerRadius = 20 //테두리 둥글게
    }

}
