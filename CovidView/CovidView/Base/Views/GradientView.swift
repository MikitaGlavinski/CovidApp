//
//  GradientView.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/23/21.
//

import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var startColor: UIColor = .clear
    @IBInspectable var endColor: UIColor = .clear
    
    private var alreadyLayedShadows: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if traitCollection.userInterfaceStyle == .dark {
            backgroundColor = .black
        } else {
            backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
        }
        if alreadyLayedShadows {
            guard let sublayer = layer.sublayers?.first else { return }
            sublayer.frame.size.width = UIScreen.main.bounds.width
        } else {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
            layer.insertSublayer(gradientLayer, at: 0)
            alreadyLayedShadows = true
        }
    }
}
