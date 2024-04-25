//
//  MyNoteViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/11/17.
//

import UIKit

import KakaoSDKUser
import Kingfisher


class MyNoteViewController: UIViewController{

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImageLabel: UIImageView!
    @IBOutlet weak var mainTableView: UITableView!
    
    // 스토리보드 참조
    private let stoaryBoard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImageLabel.layer.cornerRadius = 25
        setUserInfo()
        //setCollectionView()
        setMainTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 뷰로 이동할 때 네비게이션 바를 다시 보이게 설정
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    // 테이블뷰 init
    private func setMainTableView(){
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        // 노트
        mainTableView.register(
            UINib(nibName: "NoteTableViewCell", bundle: nil),
            forCellReuseIdentifier: NoteTableViewCell.identifier)
        
        // 퀴즈
        mainTableView.register(
            UINib(nibName: "QuizTableViewCell", bundle: nil),
            forCellReuseIdentifier: QuizTableViewCell.identifier)
        
    }
    
}

extension MyNoteViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 // 노트, 퀴즈
    }
    
    // 각각 어떤 셀을 보여줄 것인지
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as? NoteTableViewCell else{
                let errorTableViewCell = UITableViewCell()
                errorTableViewCell.backgroundColor = .blue
                return errorTableViewCell
            }
            // 위임자 설정
            cell.delegate = self // 메인뷰에서 프로토콜 수행
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizTableViewCell.identifier, for: indexPath) as? QuizTableViewCell else{
                let errorTableViewCell = UITableViewCell()
                errorTableViewCell.backgroundColor = .blue
                return errorTableViewCell
            }
            // 위임자 설정
            cell.delegate = self // 메인뷰에서 프로토콜 수행
            return cell
        }
    }
    
    //셀 크기 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //let width = MyNoteViewController.width
        return self.view.frame.size.height/2 - (self.parent?.tabBarController?.tabBar.frame.height ?? 100) // 탭바 높이 만큼 제거
    }
    
    
}


// 노트 셀, 퀴즈 셀 아이템에서 화면이동하는 알고리즘을 구현
extension MyNoteViewController : NavigationDelegate{
    
    
    
    // 전체 퀴즈 보기로 이동
    func didTapGoAllQuizButton() {
        print("didTapgoAllQuizButton Did Tapped : by Protocal")
        // 이동할 뷰 찾기(전체 노트 뷰)
        let allQuizView = stoaryBoard.instantiateViewController(withIdentifier: "AllQuizViewController") as! AllQuizViewController
        // 위임자 전달
        allQuizView.delegater = self // MyNoteViewController 를 위임자로 지정
        // 화면 이동하기
        self.navigationController?.pushViewController(allQuizView, animated: true)
    }
    
    
    // 전체 노트 보기로 이동
    func didTapGoAllNoteButton() {
        print("didTapgoAllNoteButton Did Tapped : by Protocal")
        // 이동할 뷰 찾기(전체 노트 뷰)
        let allNoteView = stoaryBoard.instantiateViewController(withIdentifier: "AllNoteViewController") as! AllNoteViewController
        // 위임자 전달
        allNoteView.delegater = self // MyNoteViewController 를 위임자로 지정
        // 화면 이동하기
        self.navigationController?.pushViewController(allNoteView, animated: true)
    }
    
    // 노트 페이지로 이동(노트 셀 클릭시)
    func didTappedNoteCell() {
        print("didTappedNoteCell")
        
        // 노트 페이지 뷰 인스턴스 찾기
        let noteVC = stoaryBoard.instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController
        // 화면 이동하기
        self.navigationController?.pushViewController(noteVC, animated: true)
    }
    
    // 퀴즈 페이지로 이동(퀴즈 셀 클릭시)
    func didTappedQuizCell() {
        print("didTappedQuizCell")
        
        // 퀴즈 페이지 뷰 인스턴스 찾기
        let quizVC = stoaryBoard.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
        // 화면 이동하기
        self.navigationController?.pushViewController(quizVC, animated: true)
    }
    
    
}
