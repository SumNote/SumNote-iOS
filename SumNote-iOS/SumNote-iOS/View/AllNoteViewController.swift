//
//  AllNoteViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/03.
//

import UIKit


// 사용자가 보유중인 모든 노트 목록을 보여줌
class AllNoteViewController: UIViewController {
    
    @IBOutlet weak var allNoteTableView: UITableView!
    
    weak var delegater : NavigationDelegate? // MyNoteView를 위임자로 설정
    
    @IBOutlet weak var backBtn: UIImageView! // 뒤로가기버튼(이미지)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
        // 뒤로가기 이벤트 정의
        // 탭 제스처 인식기 설정 => 뒤로가기 버튼 사용을 위해
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backBtnTapped))
        backBtn.isUserInteractionEnabled = true // 사용자 상호작용 활성화
        backBtn.addGestureRecognizer(tapGesture)
    }
    
    func setTableView(){
        allNoteTableView.delegate = self
        allNoteTableView.dataSource = self
        
        // 사용할 셀 등록
        allNoteTableView.register(UINib(nibName: "AllNoteTableViewCell", bundle: nil), forCellReuseIdentifier: AllNoteTableViewCell.identifier)
        
        
    }
    
    // 뷰가 실행되고 난 이후 (네비게이션 바 커스텀을 위해 상단 바 숨기기)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // 뷰가 사라질 때 (네비게이션 바 다시 보일 수 있도록)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 뷰로 이동할 때 네비게이션 바를 다시 보이게 설정
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // 백 버튼 탭 처리
    // 네비게이션 컨트롤러에서 현재 뷰 컨트롤러 제거
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        print("뒤로가기 클릭됨")
    }

}

// 테이블 뷰 설정
extension AllNoteViewController : UITableViewDelegate,UITableViewDataSource{
    // 사용할 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // 서버로부터 얻어온 모든 노트의 개수만큼
    }
    
    // 보여줄 셀의 모습 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 사용할 셀
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllNoteTableViewCell.identifier, for: indexPath) as? AllNoteTableViewCell else{
            let errorCell = UITableViewCell()
            errorCell.backgroundColor = .blue
            return errorCell
        }
        
        // 모듈러 연산을 사용하여 노트 이미지를 돌려쓸수 있도록
        let noteNum = (indexPath.row)%8+1
        cell.noteImage.image = UIImage(named: "img_note_\(noteNum)")
        
        // 셀 클릭 이벤트 제거(회색 배경 안뜨드록)
        cell.selectionStyle = .none
        
        return cell
    }
    
    // 셀 클릭시 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("allNoteTableViewCell Clicked : \(indexPath.row)")
        delegater?.didTappedNoteCell() // 노트 셀 클릭됨
    }
}

