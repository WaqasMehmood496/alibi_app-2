//
//  UIButton+Additions.swift
//  TradeAir
//
//  Created by Adeel on 08/10/2019.
//  Copyright © 2019 Buzzware. All rights reserved.
//

import UIKit

class UIButton_Additions: NSObject {

}
extension UIButton {
    enum iconPosition {
        case center,left,right
    }
    enum roundingCorner {
        case top,bottom,left,right
    }
    enum arrowDirection {
        case up,down,linear,left,right,check,uncheck,dot
    }
    
    func drawLine(iconPosition position: iconPosition, direction:arrowDirection) {
        switch position {
        case .center:
            let center = self.center
            let fromPoint = CGPoint(x: center.x - 20, y: center.y)
            let toPoint = CGPoint(x: center.x + 20, y: center.y)
            self.drawLine(onLayer: self.layer, fromPoint: fromPoint, toPoint: toPoint, arrowDirection: direction)
        case .left:
            break
        case .right:
            break
            
        }
    }
    
    fileprivate func drawLine(onLayer layer: CALayer, fromPoint start: CGPoint, toPoint end: CGPoint, arrowDirection direction: arrowDirection) {
        let startPoint = start
        let center = self.center
        var lineCenter = CGPoint()
        switch direction {
        case .up:
            if layer.sublayers!.count > 0 {
                for lay in layer.sublayers! {
                    lay.removeFromSuperlayer()
                }
            }
            lineCenter = CGPoint(x: center.x, y: start.y - 8)
        case .down:
            if layer.sublayers == nil {
                lineCenter = CGPoint(x: center.x, y: start.y + 8)
                break }
            for lay in layer.sublayers! {
                lay.removeFromSuperlayer()
            }
            lineCenter = CGPoint(x: center.x, y: start.y + 8)
        case .linear:
            for lay in layer.sublayers! {
                lay.removeFromSuperlayer()
            }
            lineCenter = center
        case .left:
            break
        case .right:
            break
        case .check:
            break
        case .uncheck:
            break
        case .dot:
            break
            
        }
        
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: startPoint)
        linePath.addLine(to: lineCenter)
        linePath.move(to: lineCenter)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.lineWidth = 5
        line.lineCap = CAShapeLayerLineCap.round
        line.lineJoin = CAShapeLayerLineJoin.round
        line.fillColor = UIColor.red.cgColor
        line.opacity = 1.0
        line.strokeColor = UIColor.red.cgColor
        layer.addSublayer(line)
    }
    func drawCorner(roundTo: roundingCorner){
        switch roundTo {
        case .top:
            return self.layer.maskedCorners =  [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        case .bottom:
            return self.layer.maskedCorners =  [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        case .left:
            return self.layer.maskedCorners =  [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        case .right:
            return self.layer.maskedCorners =  [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        
        }
    }
}
