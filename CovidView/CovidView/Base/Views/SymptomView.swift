//
//  SymptomView.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/30/21.
//

import UIKit

@IBDesignable
class SymptomView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var image: UIImage = UIImage()
    @IBInspectable var text: String = ""

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    private var alredyLayedShadows: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if alredyLayedShadows {
            clearShadows()
        }
        guard let view = loadViewFromNib(nibName: "SymptomView") else { return }
        view.frame = bounds
        addSubview(view)
        let firstShadowLayer = makeShadowLayer(shadowColor: .lightGray, offsetSize: .init(width: 5, height: 5), opacity: 0.2, radius: 10, rect: bounds)
        let secondShadowLayer = makeShadowLayer(shadowColor: .lightGray, offsetSize: .init(width: -2, height: -2), opacity: 0.2, radius: 10, rect: bounds)
        view.layer.insertSublayer(firstShadowLayer, at: 0)
        view.layer.insertSublayer(secondShadowLayer, at: 1)
        view.layer.masksToBounds = false
        alredyLayedShadows = true

        view.layer.cornerRadius = 18
        layer.cornerRadius = cornerRadius
        imageView.image = image
        label.text = text
        backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
    }
}
