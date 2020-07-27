//
//  SlantedView.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

@IBDesignable
class SlantedView: UIView {
    
    @IBInspectable var slantHeight: CGFloat = 40 { didSet { updatePath() } }
    
    private let shapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 0
        shapeLayer.fillColor = UIColor.white.cgColor
        return shapeLayer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }
    
    private func updatePath() {
        let path = UIBezierPath()
        path.move(to: bounds.origin)
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY - slantHeight))
        path.close()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
}
