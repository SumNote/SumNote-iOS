//
//  ResultDialog.swift
//  SumNote-iOS
//
//  Created by Choi76 on 5/5/24.
//
import UIKit

// LoadingIndicator의 성공, 실패 여부를 표시하기 위한 다이얼로그
class ResultDialog {
    
    static let shared = ResultDialog()

    private var backgroundView: UIView?
    private var resultImageView: UIImageView?
    private var label: UILabel?

    private init() {}
    
    func showDialog(isSuccess: Bool, message: String, delayTime : Double) {
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first(where: { $0.isKeyWindow })
            else { return }

            let backgroundView = UIView(frame: window.bounds)
            backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            
            let resultImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            resultImageView.image = UIImage(named: isSuccess ? "success_img" : "fail_img")
            resultImageView.center = window.center
            
            backgroundView.addSubview(resultImageView)
            
            let label = UILabel(frame: CGRect(x: window.bounds.midX - 100, y: window.center.y + 60, width: 200, height: 50))
            label.text = message
            label.textAlignment = .center
            label.textColor = .white
            backgroundView.addSubview(label)
            
            window.addSubview(backgroundView)

            self.backgroundView = backgroundView
            self.resultImageView = resultImageView
            self.label = label

            // 0.5초 이후 다이얼로그 종료
            DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                backgroundView.removeFromSuperview()
            }
        }
    }
}
