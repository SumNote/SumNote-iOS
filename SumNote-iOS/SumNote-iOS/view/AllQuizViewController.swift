//
//  AllQuizViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/07.
//

import UIKit

class AllQuizViewController: UIViewController {

    @IBOutlet weak var allQuizTableView: UITableView!
    
    weak var delegater : NavigationDelegate? // 화면 이동을 위한 위임자 지정
    
    @IBOutlet weak var backBtn: UIImageView! // 뒤로가기 버튼(이미지)
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTableView()
        
        // 뒤로가기 이벤트 정의
        // 탭 제스처 인식기 설정 => 뒤로가기 버튼 사용을 위해
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backBtnTapped))
        backBtn.isUserInteractionEnabled = true // 사용자 상호작용 활성화
        backBtn.addGestureRecognizer(tapGesture)
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
    
    
    // MARK: functions
    // 백 버튼 탭 처리
    // 네비게이션 컨트롤러에서 현재 뷰 컨트롤러 제거
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
        self.log("backBtnTapped")
    }
    
    private func setTableView(){
        allQuizTableView.delegate = self
        allQuizTableView.dataSource = self
        
        //nib 등록
        allQuizTableView.register(UINib(nibName: "AllQuizTableViewCell", bundle: nil), forCellReuseIdentifier: AllQuizTableViewCell.identifier)
    }
    
    

}

extension AllQuizViewController : UITableViewDelegate,UITableViewDataSource{
    // 몇개의 데이터를 보여줄 것인지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // 어떤 셀을 보여줄 것인지
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllQuizTableViewCell.identifier, for: indexPath) as? AllQuizTableViewCell else{
            // 보여줄 셀의 모습 지정
            let errorCell = UITableViewCell()
            errorCell.backgroundColor = .blue
            return errorCell
        }
        
        // 퀴즈 이미지 지정
        let quizNum = (indexPath.row)%6+1
        cell.quizImage.image = UIImage(named: "img_quiz_\(quizNum)")
        
        // 셀 클릭 이벤트 제거(회색 배경 안뜨드록)
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    // 화면 클릭 이벤트 발생시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegater?.didTappedQuizCell() // 위임자를 이용하여 화면 이동
    }
    
    
}

extension AllQuizViewController {
    private func log(_ message : String){
        print("📌[AllQuizViewController] \(message)📌")
    }
}
