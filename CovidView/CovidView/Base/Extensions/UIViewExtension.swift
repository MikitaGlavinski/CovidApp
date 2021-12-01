//
//  UIViewExtension.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/30/21.
//

import UIKit

extension UIView {
    
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func makeShadowLayer(shadowColor: UIColor, offsetSize: CGSize, opacity: Float, radius: CGFloat, rect: CGRect) -> CALayer {
        let shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: layer.cornerRadius)
        let shadowLayer = CALayer()
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.backgroundColor = backgroundColor?.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.cornerRadius = layer.cornerRadius
        shadowLayer.shadowOffset = offsetSize
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius
        shadowLayer.masksToBounds = false
        shadowLayer.position = CGPoint(x: rect.midX, y: rect.midY)
        shadowLayer.frame = rect
        return shadowLayer
    }
    
    func clearShadows() {
        guard let sublayers = layer.sublayers, sublayers.count >= 2 else { return }
        sublayers[0].removeFromSuperlayer()
        sublayers[1].removeFromSuperlayer()
    }
}
