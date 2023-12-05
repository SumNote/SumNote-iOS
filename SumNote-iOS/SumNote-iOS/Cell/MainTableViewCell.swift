//
//  MainTableViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/05.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel! // 최근 노트/퀴즈 보기
    @IBOutlet weak var btnViewAll: UIButton! // 전체보기

    
    //테이블 뷰 생성시 가장 먼저 호출?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //테이블 뷰를 선택했을 때의 동작
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //컬렉션뷰 확장 코드 작성 필요
    
}
