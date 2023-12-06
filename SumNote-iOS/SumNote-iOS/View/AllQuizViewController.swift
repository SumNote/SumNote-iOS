//
//  AllQuizViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/07.
//

import UIKit

class AllQuizViewController: UIViewController {

    @IBOutlet weak var allQuizTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTableView()
        
    }
    
    private func setTableView(){
        allQuizTableView.delegate = self
        allQuizTableView.dataSource = self
        
        //nib 등록
    }

}

extension AllQuizViewController : UITableViewDelegate,UITableViewDataSource{
    // 몇개의 데이터를 보여줄 것인지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 보여줄 셀의 모습 지정
        let errorCell = UITableViewCell()
        errorCell.backgroundColor = .blue
        return errorCell
    }
    
    
}
