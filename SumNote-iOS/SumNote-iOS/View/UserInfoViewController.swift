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
        setCollectionView()
    }
    
    func setCollectionView(){
        developerInfoCollectionView.delegate = self
        developerInfoCollectionView.dataSource = self
        
        //사용할 셀 등록
        developerInfoCollectionView.register(UINib(nibName: "DeveloperInfoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DeveloperInfoCollectionViewCell.identifier)
        
        developerInfoCollectionView.register(UINib(nibName: "TitleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
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
        
        // 0번째 셀인 경우 타이틀 셀로 지정
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        
        // 다른 셀인 경우 정보 주입
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeveloperInfoCollectionViewCell.identifier, for: indexPath) as? DeveloperInfoCollectionViewCell else{
            let errorCell = UICollectionViewCell()
            errorCell.backgroundColor = .blue

            return errorCell
        }
        return cell
    }
}

// 레이아웃 크기 설정
extension UserInfoViewController : UICollectionViewDelegateFlowLayout{
    
    //높이와 너비 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewFrameSize = self.view.frame.size
        let height = viewFrameSize.height
        let width = viewFrameSize.width
        // 타이틀 셀의 경우 높이 5분의 2정도로 지정
        if indexPath.row == 0{
            return CGSize(width: width, height: height*2/5)
        }
        
        
        return CGSize(width: width, height: height/2)
    }
    
    //아이템 사이의 행(가로 사이의 여백) 간격 지정
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 20
//    }

}
