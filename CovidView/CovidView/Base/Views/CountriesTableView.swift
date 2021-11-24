//
//  CountriesTableView.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/24/21.
//

import UIKit

@IBDesignable class CountriesTableView: UITableView {
    
    override func draw(_ rect: CGRect) {
        let firstShadowLayer = makeShadowLayer(shadowColor: .lightGray, offsetSize: .init(width: 5, height: 5), opacity: 0.1, radius: 10, rect: rect)
        let secondShadowLayer = makeShadowLayer(shadowColor: .lightGray, offsetSize: .init(width: -2, height: -2), opacity: 0.05, radius: 10, rect: rect)
        layer.insertSublayer(firstShadowLayer, at: 0)
        layer.insertSublayer(secondShadowLayer, at: 1)
        self.layer.masksToBounds = false
    }
    
    private func makeShadowLayer(shadowColor: UIColor, offsetSize: CGSize, opacity: Float, radius: CGFloat, rect: CGRect) -> CALayer {
        let shadowPath = UIBezierPath(rect: rect)
        let shadowLayer = CALayer()
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.backgroundColor = self.backgroundColor?.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = offsetSize
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius
        shadowLayer.masksToBounds = false
        shadowLayer.position = CGPoint(x: rect.midX, y: rect.midY)
        shadowLayer.frame = rect
        return shadowLayer
    }
}
