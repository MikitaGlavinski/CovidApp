//
//  TextFieldBackView.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/23/21.
//

import UIKit

@IBDesignable class TextFieldBackView: UIView {
    @IBInspectable var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { layer.borderWidth }
    }
    
    @IBInspectable var borderColor: UIColor {
        set { layer.borderColor = newValue.cgColor }
        get { UIColor(cgColor: layer.borderColor ?? CGColor(gray: 0, alpha: 0)) }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius }
    }
}
