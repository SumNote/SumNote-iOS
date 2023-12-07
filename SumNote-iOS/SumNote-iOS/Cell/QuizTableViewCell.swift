//
//  QuizTableViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/06.
//

import UIKit

// MyNoteView에서 노트 프리뷰를 제공
// 사용자가 보유중인 노트중 5개를 최근 노트로 보여줌
// MyNoteListCollectionViewCell을 CollectionView를 통해 보여준다.

class QuizTableViewCell: UITableViewCell {
    
    static let identifier = "QuizTableViewCell"
    
    weak var delegate : MyNoteTableViewDelegate? // 위임자 선언 => MyNoteTableViewController(메인화면)
    
    // 서버로부터 얻어올 퀴즈 데이터 리스트 작성 필요
    @IBOutlet weak var MyQuizListCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setMyQuizListCollectionView() // CollectioView init
        
        getMyQuiz()
    }
    
    // 컬렉션뷰 init
    func setMyQuizListCollectionView(){
        MyQuizListCollectionView.dataSource = self
        MyQuizListCollectionView.delegate = self
        
        // 사용할 nib파일 등록
        MyQuizListCollectionView.register(UINib(
            nibName: "MyQuizListCollectionViewCell",
            bundle: nil), forCellWithReuseIdentifier: MyQuizListCollectionViewCell.identifier)
        
    }
    

    // 서버로부터 보유중인 퀴즈 얻어오는 동작 작성 필요
    func getMyQuiz(){
        print("서버에서 퀴즈 얻어오기")
    }
    
    
    //MARK: 전체 보기
    @IBAction func goAllQuizBtnDidTapped(_ sender: Any) {
        delegate?.didTapGoAllQuizButton() // 위임
    }
    
    // 해당 테이블 셀 클릭시 동작 정의(정의 x => 컨테이너 역할)
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension QuizTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    
    // 몇개의 셀을 보여줄 것인지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 //5개보다 적을 경우 리스트 숫자만큼 반환하도록 수정 필요
    }
    
    // 보여줄 셀의 형태 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyQuizListCollectionViewCell.identifier, for: indexPath) as? MyQuizListCollectionViewCell else {
            let errorCell = UICollectionViewCell()
            errorCell.backgroundColor = .blue
            return errorCell
        }
        return cell
    }
    
    
}

/**
 //컬렉션 뷰의 셀 사이즈 조절 => 테이블 뷰와 다른 방식을 사용함
 //nib파일은 ui작업을 도와주는 용도일 뿐이라, nib에서 커스텀을 진행해도 반영되지 않음
 //크기에 대한 작업은 프로토콜로 해야함
 extension ProfileViewController: UICollectionViewDelegateFlowLayout{
     
  
     //CGSize를 리턴함 => 셀에 따라서 다른 크기를 리턴해야함 => 셀은 섹션에 소속되어있음 => 섹션을 확인하고 맞춰서 크기 지정필요
     func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
         let section = indexPath.section
         
         switch section{
         case 0: // 프로필 화면을 보여주기 위한 셀에 대한 크기 지정
             return CGSize(
                 width: collectionView.frame.width,
                 height: CGFloat(159)
             )
         default: // 피드 셀에 대한 크기 지정 => 한 화면에 3개씩 들어가도록 하는것이 목표라면 3으로 나눠줘야함
             //한 화면의 크기 확보
             //collectionview의 가로의 3분의 1씩 가져간다면 가운데 부분에 여백이 2개 생길것 => 여백을 1씩 둘 예정이므로(아래 함수 참고) 미리 -2를 해둔다.
             
             //수정 -2 => -4/3 : 한 가로에 아이템이 3개씩 들어가는 것이 우리의 목표
             //3개가 들어가면 여백은 총 4개가 발생함(*ㅁ*ㅁ*ㅁ*) 따라서 전체적으로 4를 빼줘야함
             //한 셀에 대해 여백이 총 6번 제거되므로(왼쪽,오른쪽에 대해 여백이 지정됨)
             //총 4의 여백을 지정해주기 위해선 4/3을 빼줘야함
             //(가로에 들어가는 것의 개수는 3개, 한 셀당 빼기 연산을 한번씩 수행, 같은 연산 3번 수행했을때 총 4가 빠지려면? => 4/3을 빼줘야함 4/3*3=4 이므로)
             let side = CGFloat((collectionView.frame.width/3)-4/3)
             return CGSize(
                 width: side, height: side //정사각형으로 지정
             )
         }
     }
     
     //아이템 사이의 행(가로 사이의 여백) 간격 지정
     func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         switch section{
         case 0: //프로필 아이템 간격은 0으로 둠
             return CGFloat(0)
         default: //위에서 말했듯이 피드 아이템간의 가로 간격을 1로 둠
             return CGFloat(1) //왼쪽, 오른쪽 각각 여백이 지정됨
         }
     }
     
     //아이템 사이의 열(세로 사이의 여백) 간격 지정
     func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         switch section{
         case 0:
             return CGFloat(0)
         default: //피드 아이템간의 높이 간격 지정
             return CGFloat(1)
         }
     }
 }

 
 
 
 */
