//
//  MainView.swift
//  CovidView
//
//  Created by Mikita Glavinski on 11/22/21.
//

import UIKit

@IBDesignable class SpreadView: UIView {
    
    override func draw(_ rect: CGRect) {
        let size = self.bounds.size
        
        let p1 = self.bounds.origin
        let p2 = CGPoint(x: p1.x + size.width, y: p1.y)
        let p3 = CGPoint(x: p2.x, y: p2.y + size.height)
        let p4 = CGPoint(x: p1.x, y: p3.y)
        let curvePoint = CGPoint(x: size.width / 2, y: p1.y + 70)
        
        let path = UIBezierPath()
        path.move(to: p1)
        path.addQuadCurve(to: p2, controlPoint: curvePoint)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.close()
        
        UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1).set()
        path.fill()
    }
}
