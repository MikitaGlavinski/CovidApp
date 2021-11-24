//
//  UIFontExtension.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/22/21.
//

import UIKit

extension UIFont {
    static func poppinsBold(with size: CGFloat) -> UIFont {
        UIFont(name: "Poppins-Bold", size: size)!
    }
    
    static func poppinsMedium(with size: CGFloat) -> UIFont {
        UIFont(name: "Poppins-Medium", size: size)!
    }
    
    static func poppinsRegular(with size: CGFloat) -> UIFont {
        UIFont(name: "Poppins-Regular", size: size)!
    }
}
