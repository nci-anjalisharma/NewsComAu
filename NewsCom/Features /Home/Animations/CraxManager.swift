//
//  CraxManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 23/07/26.
//

import UIKit

////honestly don't know what it is but its huge and colorful

class CraxManager {
    static func launch(in view: UIView) {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        emitter.emitterShape = .rectangle
        emitter.emitterSize = view.bounds.size
        
        // 1. Organic Ribbon Confetti
        let confetti = createCell(content: .ribbon)
        confetti.redRange = 0.8
        confetti.greenRange = 0.8
        confetti.blueRange = 0.8 // Randomizes colors
        confetti.velocity = 200
        confetti.yAcceleration = 180
        
        // 2. Rising Balloons
        let balloon = createCell(content: .balloon)
        balloon.scale = 0.5
        balloon.velocity = 120
        balloon.yAcceleration = -80
        balloon.emissionLongitude = 0
        
        // 3. Pro Sparkles (Twinkling stars)
        let sparkle = createCell(content: .sparkle)
        sparkle.birthRate = 10
        sparkle.velocity = 60
        sparkle.scale = 0.1
        sparkle.scaleRange = 0.1
        sparkle.alphaSpeed = -0.4
        // This creates the "pulsing" twinkle effect
        sparkle.scaleSpeed = 0.2
        
        emitter.emitterCells = [confetti, balloon, sparkle]
        view.layer.addSublayer(emitter)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            emitter.birthRate = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                emitter.removeFromSuperlayer()
            }
        }
    }

    private static func createCell(content: ShapeType) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 15
        cell.lifetime = 4.0
        cell.velocityRange = 100
        cell.emissionRange = .pi * 2
        cell.spin = 4
        cell.spinRange = 4
        cell.contents = drawShape(content)?.cgImage
        return cell
    }

    enum ShapeType { case ribbon, balloon, sparkle }

    private static func drawShape(_ type: ShapeType) -> UIImage? {
        let size = CGSize(width: 60, height: 60)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        
        UIColor.white.setFill()
        
        switch type {
        case .ribbon:
            // A curved ribbon shape
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 10, y: 10))
            path.addCurve(to: CGPoint(x: 40, y: 40), controlPoint1: CGPoint(x: 50, y: 0), controlPoint2: CGPoint(x: 0, y: 50))
            path.lineWidth = 8
            path.lineCapStyle = .round
            UIColor.white.setStroke()
            path.stroke()
            
        case .balloon:
            // Ovoid balloon with a little "string" nub
            let path = UIBezierPath(ovalIn: CGRect(x: 15, y: 5, width: 30, height: 40))
            path.fill()
            let triangle = UIBezierPath()
            triangle.move(to: CGPoint(x: 30, y: 45))
            triangle.addLine(to: CGPoint(x: 25, y: 55))
            triangle.addLine(to: CGPoint(x: 35, y: 55))
            triangle.fill()
            
        case .sparkle:
            // 4-pointed star (Glow style)
            let center = CGPoint(x: 30, y: 30)
            for i in 0..<4 {
                let path = UIBezierPath(ovalIn: CGRect(x: 28, y: 0, width: 4, height: 60))
                ctx.saveGState()
                ctx.translateBy(x: center.x, y: center.y)
                ctx.rotate(by: CGFloat(i) * .pi / 2)
                ctx.translateBy(x: -center.x, y: -center.y)
                path.fill()
                ctx.restoreGState()
            }
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


