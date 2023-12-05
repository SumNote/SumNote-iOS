//
//  MyNoteViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/11/17.
//

import UIKit

import KakaoSDKUser
import Kingfisher

class MyNoteViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImageLabel: UIImageView!

    // 메인 테이블 뷰 데이터 리스트
    private let mainTableViewModelList : [MainTableViewModel] = [
        MainTableViewModel(title: "최근 노트 보기", type: MainTableViewType.NOTE),
        MainTableViewModel(title: "최근 푼 문제 보기", type: MainTableViewType.QUIZ)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        userImageLabel.layer.cornerRadius = 25
        setUserInfo()
        //setCollectionView()
    }
    
    // 사용자 정보 얻어오기(카카오톡 사용자 정보)
    private func setUserInfo(){
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            } else if let userInfo = KaKaoAPI.shared.extractUserInfo(user) {
                print("### Extracted User Info: \(userInfo)")
                self.userNameLabel.text = userInfo["nickname"] as? String
                let urlString = userInfo["profileImage"]
                let url = URL(string: urlString as! String)
                self.userImageLabel.kf.setImage(with:url)
                
                self.userEmailLabel.text = userInfo["email"] as? String
            }
        }
    }
    
    // 컬렉션뷰 초기 설정 Delgate, Datasource 위임
//    private func setCollectionView(){
//        //note collectionview init
//        noteCollectionView.dataSource = self
//        noteCollectionView.delegate = self
//
//        //Nib 등록
//        noteCollectionView.register(UINib(nibName: "MyNoteListCollectionViewCell", bundle: nil),
//                      forCellWithReuseIdentifier: MyNoteListCollectionViewCell.identifier)
//
//
//        //quiz collectionview init
//        quizCollectionView.dataSource = self
//        quizCollectionView.delegate = self
//
//        //Nib 등록
//        quizCollectionView.register(UINib(nibName: "MyQuizListCollectionViewCell", bundle: nil),
//                      forCellWithReuseIdentifier: MyQuizListCollectionViewCell.identifier)
//
//
//    }
//
    
    //MARK: 노트 전체 보기
    @IBAction func btnViewAllNoteDidTapped(_ sender: Any) {
        // 뷰 이동
        // 1. 스토리보드 찾기
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // 2. 이동할 뷰 찾기
        let AllNoteView = storyboard
            .instantiateViewController(withIdentifier: "AllNoteViewController") as! AllNoteViewController
        // 3. 이동
        self.navigationController?.pushViewController(AllNoteView, animated: true)
        
    }
    
    
    //MARK: 퀴즈 전체 보기
    @IBAction func btnViewAllQuizDidTapped(_ sender: Any) {
    }
    
    
    
    
}

//extension MyNoteViewController : UICollectionViewDelegate,UICollectionViewDataSource{
//
//    //몇개의 셀을 보여줄 것인지
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == self.noteCollectionView { // 노트 컬렉션 뷰라면
//            // 노트 컬렉션 뷰의 아이템 수
//            return 5
//        } else if collectionView == self.quizCollectionView { // 퀴즈 컬렉션 뷰라면
//            // 퀴즈 컬렉션 뷰의 아이템 수
//            return 4
//        }
//        return 0
//    }
//
//    //어떤 셀을 보여줄 것인지
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // 노트 컬렉션 뷰일 경우
//        if collectionView == self.noteCollectionView {
//            //퀴즈 컬렉션 뷰
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyNoteListCollectionViewCell.identifier, for: indexPath) as? MyNoteListCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            // 여기서 cell을 설정합니다.
//            return cell
//        } else if collectionView == self.quizCollectionView { // 퀴즈 컬렉션 뷰일 경우
//            // 퀴즈 컬렉션 뷰 셀
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyQuizListCollectionViewCell.identifier, for: indexPath) as? MyQuizListCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            // 여기서 cell을 설정합니다.
//            return cell
//        }
//        return UICollectionViewCell()
//    }
//
//
//}
