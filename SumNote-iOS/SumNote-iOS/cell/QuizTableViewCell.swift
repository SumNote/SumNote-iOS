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
    
    weak var delegate : NavigationDelegate? // 위임자 선언 => MyNoteTableViewController(메인화면)
    
    // 변경사항 발생시 컬렉션 뷰 새로고침
    var quizDocList : [QuizDocDto] = [] {
        didSet{
            self.myQuizListCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var myQuizListCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setMyQuizListCollectionView() // CollectioView init
        
        getMyQuizDoc()
    }
    
    // 컬렉션뷰 init
    func setMyQuizListCollectionView(){
        myQuizListCollectionView.dataSource = self
        myQuizListCollectionView.delegate = self
        
        // 사용할 nib파일 등록
        myQuizListCollectionView.register(UINib(
            nibName: "MyQuizListCollectionViewCell",
            bundle: nil), forCellWithReuseIdentifier: MyQuizListCollectionViewCell.identifier)
        
    }
    
    func getMyQuizDoc(){
        self.log("getMyQuizDoc")
        SpringAPIService.shared.getQuizRequest(type: "home"){ isSuccess, quizDocList in
            if isSuccess {
                self.quizDocList = quizDocList
            } else {
                // 실패시 동작 작성 필요
                self.quizDocList = []
            }
        }
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
        if self.quizDocList.count < 5 {
            return self.quizDocList.count
        }
        return 5 //5개보다 적을 경우 리스트 크기만큼 반환
    }
    
    // 보여줄 셀의 형태 지정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyQuizListCollectionViewCell.identifier, for: indexPath) as? MyQuizListCollectionViewCell else {
            let errorCell = UICollectionViewCell()
            errorCell.backgroundColor = .blue
            return errorCell
        }
        
        // 퀴즈 이미지 지정
        let quizNum = (indexPath.row)%6+1
        cell.quizUIImage.image = UIImage(named: "img_quiz_\(quizNum)")
        
        // 데이터 바인딩
        let currQuizDoc = quizDocList[indexPath.row]
        cell.quizTitleLabel.text = currQuizDoc.title!
        cell.quizGenTimeLabel.text = currQuizDoc.lastModifiedAt!
        
        
        return cell
    }
    
    // 셀 클릭시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currQuizDoc = quizDocList[indexPath.row]
        SpringAPIService.shared.getQuizPageRequest(quizId: currQuizDoc.quizId){ isSuccess, quizPageData in
            if isSuccess{
                self.log("check : \(quizPageData)")
                self.delegate?.didTappedQuizCell(quizPageData: quizPageData!, quizTitle: currQuizDoc.title!)
            } else {
                // 예외 처리 작성 필요
            }
            
        }
        
    }
    
}

// 셀 크기 동적으로 정의
// 노트의 높이는 컬렉션뷰 셀의 높이만큼, 가로는 2분의 1정도 => 셀 왼쪽 간격 지정 필요
extension QuizTableViewCell : UICollectionViewDelegateFlowLayout{
    
    //높이와 너비 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewFrameSize = self.myQuizListCollectionView.frame.size
        let height = collectionViewFrameSize.height
        let width = collectionViewFrameSize.width
        
        return CGSize(width: width-20, height: height/2-20)
    }
    
}

extension QuizTableViewCell {
    private func log(_ message : String){
        print("📌[QuizTableViewCell] \(message)📌")
    }
}
