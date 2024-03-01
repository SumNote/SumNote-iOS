//
//  QuizViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2023/12/16.
//

import UIKit

// 퀴즈페이지뷰를 포함할 퀴즈뷰
class QuizViewController: UIViewController {

    @IBOutlet weak var backBtn: UIImageView!
    // 퀴즈 제목
    @IBOutlet weak var quizTitle: UILabel!
    // 문제 전체 숫자
    @IBOutlet weak var numberOfQuiz: UILabel!
    // 현재 문제 인덱스
    @IBOutlet weak var currentIndex: UILabel!
    // 프로그래스바
    @IBOutlet weak var progressBar: UIProgressView!
    // 퀴즈 페이지 뷰 컨테이너
    @IBOutlet weak var quizPageViewContainer: UIView!
    // 퀴즈 페이지 뷰
    var quizPageViewController : UIPageViewController!
    
    var quizData : [String] = [] // 사용자에게 보여줄 데이터 => 서버로부터 얻어온 결과물
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 뒤로가기 이벤트 정의
        // 탭 제스처 인식기 설정 => 뒤로가기 버튼 사용을 위해
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backBtnTapped))
        backBtn.isUserInteractionEnabled = true // 사용자 상호작용 활성화
        backBtn.addGestureRecognizer(tapGesture)
        
        fetchQuizData() // 서버로부터 퀴즈 정보 얻어오기
        numberOfQuiz.text = "/\(quizData.count)"
        
        //스토리보드를 사용하여 QuizPageViewController 인스턴스화 & 자식 VC로 지정
        if let quizPageVC = storyboard?.instantiateViewController(withIdentifier: "QuizPageViewController") as? QuizPageViewController {
            quizPageVC.delegater = self // 위임자 지정
            self.quizPageViewController = quizPageVC
            self.addChild(quizPageVC) // 자식 뷰 컨트롤러로 추가
            self.quizPageViewContainer.addSubview(quizPageVC.view) // containerView에 뷰 추가
            // 퀴즈 배열 넘기기
            quizPageVC.quizData = self.quizData

            // MyPageViewController의 뷰 크기 및 위치 조정(자식으로 지정)
            quizPageVC.view.frame = quizPageViewContainer.bounds
            quizPageVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            quizPageVC.didMove(toParent: self)
            
            // 시작 페이지 설정
            if let startingViewController = quizPageVC.getQuizContent(at: 0) {
                quizPageVC.setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
                setProgressBar(index: 1) // 프로그래스바 진행도 설정
            }
        }
        
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
    // 서버로부터 데이터 얻어오기
    private func fetchQuizData(){
        let data = ["Quiz1","Quiz2","Quiz3","Quiz4","Quiz5"] // 퀴즈로 제공할 정보 배열(테스트용)
        print("퀴즈 데이터 얻어옴..")
        self.quizData = data
        
    }
    
    // 백 버튼 탭 처리
    @objc func backBtnTapped() {
        // 네비게이션 컨트롤러에서 현재 뷰 컨트롤러 제거
        self.navigationController?.popViewController(animated: true)
        print("뒤로가기 클릭됨")
    }
    
    
    
}

extension QuizViewController : QuizViewDelegate {
    // 프로그래스 바 진행도 표시
    func setProgressBar(index: Int) {
        print("progress -> \(index)")
        let totalQuestions = self.quizData.count // 전체 퀴즈의 수
        let progress = Float(index) / Float(totalQuestions)
        progressBar.setProgress(progress, animated: true)
    }
    
    //
    func setQuizIndex(index: Int) {
        print("QuizIndex -> \(index)")
        currentIndex.text = "\(index)"
        setProgressBar(index: index) // 인덱스 업데이트 시 프로그래스바도 업데이트
    }
    
    
}
