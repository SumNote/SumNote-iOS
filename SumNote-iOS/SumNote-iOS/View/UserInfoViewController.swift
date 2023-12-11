//
//  UserInfoViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/11/17.
//

import UIKit

// 개발자 정보 페이지
class UserInfoViewController: UIViewController {

    @IBOutlet weak var developerInfoCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setCollectionView(){
        developerInfoCollectionView.delegate = self
        developerInfoCollectionView.dataSource = self
        
        // 사용할 셀 등록
    }
    
}

// collectionview 프로토콜 채택
extension UserInfoViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    // 메인 화면, 강민서, 김태하, 최강, 이경민
    // 5개의 셀 사용 예정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // 셀 등록
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    
}
