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
    
    private var alredyLayedShadows: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if alredyLayedShadows {
            clearShadows()
        }
        let firstShadowLayer = makeShadowLayer(shadowColor: .lightGray, offsetSize: .init(width: 5, height: 5), opacity: 0.2, radius: 10, rect: bounds)
        let secondShadowLayer = makeShadowLayer(shadowColor: .lightGray, offsetSize: .init(width: -2, height: -2), opacity: 0.2, radius: 10, rect: bounds)
        layer.insertSublayer(firstShadowLayer, at: 0)
        layer.insertSublayer(secondShadowLayer, at: 1)
        layer.masksToBounds = false
        alredyLayedShadows = true
    }
}
