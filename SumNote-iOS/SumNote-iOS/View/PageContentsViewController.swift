//
//  PageContentsViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/13.
//

import UIKit

// 테스트용 더미 데이터
class PageContentsViewController: UIViewController {
    
    private var titleString = String()

    @IBOutlet weak var titleTextLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
       
    init(titleString: String) {
        super.init(nibName: nil, bundle: nil) // ?
        self.titleString = titleString
    }

    // ??
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    // 값 할당?
    private func setupUI() {
        //view.backgroundColor = .systemBackground
        titleTextLabel.text = titleString
    }
}
