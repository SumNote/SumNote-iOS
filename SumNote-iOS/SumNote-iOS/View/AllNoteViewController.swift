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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    func setTableView(){
        allNoteTableView.delegate = self
        allNoteTableView.dataSource = self
        
        // 사용할 셀 등록
        allNoteTableView.register(UINib(nibName: "AllNoteTableViewCell", bundle: nil), forCellReuseIdentifier: AllNoteTableViewCell.identifier)
        
        
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
        return cell
    }
}

