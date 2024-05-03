//
//  NoteTableViewCell.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/06.
//

import UIKit

// MyNoteView에서 노트 프리뷰를 제공
// 사용자가 보유중인 노트중 5개를 최근 노트로 보여줌
// MyNoteListCollectionViewCell을 CollectionView를 통해 보여준다.
// 위밈을 통해, 화면이동은 MyNoteTableViewController에서 수행한다.
class NoteTableViewCell: UITableViewCell {

    static let identifier = "NoteTableViewCell"
    
    weak var delegate : NavigationDelegate? // 위임자 선언 => MyNoteTableViewController(메인화면)
    
    @IBOutlet weak var myNoteListCollectionView: UICollectionView!
    
    var noteList : [NoteDto] = [] {
        didSet{
            self.myNoteListCollectionView.reloadData()
        }
    }
    
    // CollectionView에 대한 Delegate,Datasource선언
    override func awakeFromNib() {
        super.awakeFromNib()
        self.log("awakeFromNib")
        // Initialization code
        setMyNoteListCollectionView() // CollectioView init
        
        getMyNote()
    }
    
    // 전체 보기 버튼 클릭시 => 화면 전환
    //MARK: 전체 보기 함수
    @IBAction func goAllNoteBtnDidTapped(_ sender: Any) {
        self.log("goAllNoteBtnDidTapped : NoteTableViewCell")
        delegate?.didTapGoAllNoteButton() // 위임자에서 화면이동 프로토콜 수행
    }
    
    
    // 컬렉션뷰 init
    func setMyNoteListCollectionView(){
        myNoteListCollectionView.dataSource = self
        myNoteListCollectionView.delegate = self
        
        // 사용할 nib파일 등록
        myNoteListCollectionView.register(UINib(
            nibName: "MyNoteListCollectionViewCell",
            bundle: nil), forCellWithReuseIdentifier: MyNoteListCollectionViewCell.identifier)
        
        myNoteListCollectionView.contentInset = UIEdgeInsets(top:0, left:10, bottom:0, right: 0) // 컬렉션뷰 시작 위치 간격 설정
        
        
    }
    

    // 서버로부터 보유중인 노트 얻어오는 동작 작성 필요
    func getMyNote(){
        self.log("getMyNote")
        SpringAPI.shared.getNoteRequest(type: "home"){ isSuccess, noteList in
            if isSuccess{
                self.noteList = noteList
            } else {
                // 예외 처리 작성 필요
            }
        }
    }
    
    // 해당 테이블 셀 클릭시 동작 정의(정의 x => 컨테이너 역할)
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension NoteTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    
    // 몇개의 셀을 보여줄 것인지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 최대 5개만 보여줌
        if noteList.count < 5{
            return noteList.count
        }
        return 5
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyNoteListCollectionViewCell.identifier, for: indexPath) as? MyNoteListCollectionViewCell else {
            let errorCell = UICollectionViewCell()
            errorCell.backgroundColor = .blue
            return errorCell
        }
        
        // 정보 주입
        let note = noteList[indexPath.row]
        
        cell.noteNameLabel.text = note.title
        cell.noteGeneratedTime.text = note.lastModifiedAt
        
        // 모듈러 연산을 사용하여 노트 이미지를 돌려쓸수 있도록
        let noteNum = (indexPath.row)%8+1
        cell.noteUIImage.image = UIImage(named: "img_note_\(noteNum)")
        
        return cell
    }
    
    // 컬렉션뷰 클릭시 동작 => MyNoteView로 위임 필요
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.log("\(indexPath.row) cell clicked")
        
        let note = noteList[indexPath.row]
        SpringAPI.shared.getNotePagesReqeust(noteId: note.noteId!){ isSucess,userNotePage in
            if isSucess{
                self.delegate?.didTappedNoteCell(userNotePage!) // 얻어온 노트 정보 전달
            } else {
                // 오류 처리 필요
            }
        }
        
        
    }
    
    
}

// 셀 크기 동적으로 정의
// 노트의 높이는 컬렉션뷰 셀의 높이만큼, 가로는 2분의 1정도 => 셀 왼쪽 간격 지정 필요
extension NoteTableViewCell : UICollectionViewDelegateFlowLayout{
    
    //높이와 너비 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewFrameSize = self.myNoteListCollectionView.frame.size
        let height = collectionViewFrameSize.height
        let width = collectionViewFrameSize.width
        
        return CGSize(width: width/2, height: height)
    }
    
    //아이템 사이의 행(가로 사이의 여백) 간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

}


extension NoteTableViewCell {
    private func log(_ message : String){
        print("📌[NoteTableViewCell] \(message)📌")
    }
}
