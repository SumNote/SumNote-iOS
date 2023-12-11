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
        
        return cell
        
    }
    
    
}
