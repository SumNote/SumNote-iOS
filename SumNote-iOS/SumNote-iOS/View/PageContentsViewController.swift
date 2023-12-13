//
//  PageContentsViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/13.
//

import UIKit

// 테스트용 더미 데이터
class PageContentsViewController: UIViewController {
    
    private var titleLabel = UILabel()

    @IBOutlet weak var title: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
       
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
        
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        titleLabel.font = .preferredFont(forTextStyle: .title1)
    }
}
