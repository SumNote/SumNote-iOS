//
//  +UIView.swift
//  SumNote-iOS
//
//  Created by Choi76 on 2024/03/01.
//

import UIKit

// label, view, ImageView, 등 UIView를 상속받는 뷰들의 테두리 굵기, 굴곡, 테두리 색상 기능 확장
/**
 Border Width : 테두리 굵기

 Corner Radius : 굴곡 ( 둥근 정도 )

 Border Color : 테두리 색상
 */
extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
}
