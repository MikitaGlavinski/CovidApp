//
//  StatisticView.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/30/21.
//

import UIKit

@IBDesignable
class StatisticView: UIView {
    
    @IBInspectable var backViewBackgroundColor: UIColor = .clear
    @IBInspectable var borderViewBackgroundColor: UIColor = .clear
    @IBInspectable var borderViewBorderColor: UIColor = .clear
    @IBInspectable var labelColor: UIColor = .clear
    @IBInspectable var secondaryLabelColor: UIColor = .clear
    @IBInspectable var backViewCornerRadius: CGFloat = 0
    @IBInspectable var borderViewCornerRadius: CGFloat = 0
    @IBInspectable var borderViewBorderWidth: CGFloat = 0
    @IBInspectable var secondaryText: String = ""
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        guard let view = loadViewFromNib(nibName: "StatisticView") else { return }
        view.frame = bounds
        addSubview(view)
    }
    
    override func draw(_ rect: CGRect) {
        backView.backgroundColor = backViewBackgroundColor
        backView.layer.cornerRadius = backViewCornerRadius

        borderView.backgroundColor = borderViewBackgroundColor
        borderView.layer.borderColor = borderViewBorderColor.cgColor
        borderView.layer.borderWidth = borderViewBorderWidth
        borderView.layer.cornerRadius = borderViewCornerRadius

        countLabel.textColor = labelColor

        secondaryLabel.textColor = secondaryLabelColor
        secondaryLabel.text = secondaryText
    }
}
