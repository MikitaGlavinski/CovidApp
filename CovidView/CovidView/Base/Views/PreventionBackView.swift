//
//  PreventionBackView.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/26/21.
//

import UIKit

@IBDesignable class PreventionBackView: UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius }
    }
    
    private var alreadyLayedShadows: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if alreadyLayedShadows {
            clearShadows()
        }
        var shadowLayer: CALayer
        if traitCollection.userInterfaceStyle == .dark {
            shadowLayer = makeShadowLayer(shadowColor: .lightGray, offsetSize: .init(width: 5, height: 5), opacity: 0.2, radius: 10, rect: bounds)
        } else {
            shadowLayer = makeShadowLayer(shadowColor: .lightGray, offsetSize: .init(width: 5, height: 5), opacity: 0.2, radius: 10, rect: bounds)
        }
        layer.insertSublayer(shadowLayer, at: 0)
        self.layer.masksToBounds = false
        alreadyLayedShadows = true
    }
}
