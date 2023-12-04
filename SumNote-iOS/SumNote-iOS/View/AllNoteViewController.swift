//
//  AllNoteViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/03.
//

import UIKit


// 사용자가 보유중인 모든 노트 목록을 보여줌
class AllNoteViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    func setCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 사용할 셀 등록
        collectionView.register(UINib(nibName: "AllNoteCollectionViewCell", bundle: nil),
                      forCellWithReuseIdentifier: AllNoteCollectionViewCell.identifier)
        
        
    }

}

// 컬렉션 뷰 설정
extension AllNoteViewController : UICollectionViewDelegate,
                                  UICollectionViewDataSource{
    
    // 몇개의 셀을 보여줄 것인지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6 // 테스트용
    }
    
    
    // 어떤 셀을 보여줄 것인지
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllNoteCollectionViewCell.identifier, for: indexPath) as? AllNoteCollectionViewCell else {
            let error = UICollectionViewCell()
            print("에러 발생")
            return error
        }
        // 영역 확인용
        
        return cell
    }
    
    
}

// 컬렉션 뷰 셀 디자인 설정(가로 길이, 높이 지정)
extension AllNoteViewController : UICollectionViewDelegateFlowLayout{
    //높이와 너비 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 80) // 높이 80
    }
}
