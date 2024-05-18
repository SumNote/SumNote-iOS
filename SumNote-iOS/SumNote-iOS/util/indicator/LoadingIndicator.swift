//
//  LoadingIndicator.swift
//  SumNote-iOS
//
//  Created by Choi76 on 5/4/24.
//
import UIKit

class LoadingIndicator {
    
    static let shared = LoadingIndicator()

    private var backgroundView: UIView?
    private var indicatorImageView: UIImageView?
    private var label: UILabel?

    private init() {}

    func startIndicator(withMessage message: String = "노트를 생성하는 중입니다 ...") {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }

        let backgroundView = UIView(frame: window.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let indicatorImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        indicatorImageView.image = UIImage(named: "custom_loading_image")
        indicatorImageView.center = window.center
        
        backgroundView.addSubview(indicatorImageView)
        
        let label = UILabel(frame: CGRect(x: window.bounds.midX - 100, y: window.center.y + 60, width: 200, height: 50))
        label.text = message
        label.textAlignment = .center
        label.textColor = .white
        backgroundView.addSubview(label)
        
        window.addSubview(backgroundView)

        self.backgroundView = backgroundView
        self.indicatorImageView = indicatorImageView
        self.label = label

        startAnimation(for: indicatorImageView)
    }

    func startAnimation(for imageView: UIImageView) {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 2 // 2초 동안 한 바퀴 회전
        rotation.repeatCount = .infinity // 무한 반복
        
        imageView.layer.add(rotation, forKey: "rotationAnimation")
    }

    func finishIndicator() {
        indicatorImageView?.layer.removeAnimation(forKey: "rotationAnimation")
        backgroundView?.removeFromSuperview()
    }
}
