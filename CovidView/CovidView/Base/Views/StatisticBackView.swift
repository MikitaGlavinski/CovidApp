//
//  StatisticBackView.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/23/21.
//

import UIKit

@IBDesignable class StatisticBackView: UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius }
    }
    
    override func draw(_ rect: CGRect) {
        let firstShadowLayer = makeShadowLayer(shadowColor: .lightGray, offsetSize: .init(width: 5, height: 5), opacity: 0.1, radius: 10, rect: rect)
        let secondShadowLayer = makeShadowLayer(shadowColor: .lightGray, offsetSize: .init(width: -2, height: -2), opacity: 0.05, radius: 10, rect: rect)
        layer.insertSublayer(firstShadowLayer, at: 0)
        layer.insertSublayer(secondShadowLayer, at: 1)
        self.layer.masksToBounds = false
    }
    
    private func makeShadowLayer(shadowColor: UIColor, offsetSize: CGSize, opacity: Float, radius: CGFloat, rect: CGRect) -> CALayer {
        let shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: self.cornerRadius)
        let shadowLayer = CALayer()
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.backgroundColor = self.backgroundColor?.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.cornerRadius = self.cornerRadius
        shadowLayer.shadowOffset = offsetSize
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius
        shadowLayer.masksToBounds = false
        shadowLayer.position = CGPoint(x: rect.midX, y: rect.midY)
        shadowLayer.frame = rect
        return shadowLayer
    }
}
