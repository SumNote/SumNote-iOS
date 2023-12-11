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
    
    // 개발자 정보 데이터
    let devInfoArray = [
        DeveloperInfo(
            imageName: "img_minseo",
            devName: "강민서", devEmail: "kms02171@naver.com",
            role1: "JPA와 SpringBoot를 이용한 API 개발" ,
            role2: "Naver Cloud Flatform을 이용한 서버 배포",
            role3: "Android 디자인 개선"),
        DeveloperInfo(
            imageName: "img_taeha",
            devName: "김태하", devEmail: "xogk1128@naver.com",
            role1: "안드로이드 및 장고 서버 개발" ,
            role2: "클라이언트 서버간 API 통신 구축",
            role3: "GPT 프롬프트 엔지니어링"),
        DeveloperInfo(
            imageName: "img_choi76",
            devName: "최 강", devEmail: "y2_12@naver.com",
            role1: "Android & iOS Application 개발" ,
            role2: "Django Server 구축 및 개발",
            role3: "GPT Prompt Engineering"),
        DeveloperInfo(
            imageName: "img_geongmin",
            devName: "이경민", devEmail: "gyeongmin@hansung.ac.kr",
            role1: "OpenCV를 이용한 객체 탐지" ,
            role2: "광학 문자 인식 및 속도 개선",
            role3: "")
    ]
    
    
    
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
        let num = indexPath.row - 1
        cell.devImage.image = UIImage(named:devInfoArray[num].imageName)
        cell.devName.text = devInfoArray[num].devName
        cell.devEmail.text = devInfoArray[num].devEmail
        cell.role1.text = devInfoArray[num].role1
        cell.role2.text = devInfoArray[num].role2
        cell.role3.text = devInfoArray[num].role3
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
    
}
