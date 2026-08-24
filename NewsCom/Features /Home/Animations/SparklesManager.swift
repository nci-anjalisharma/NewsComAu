//
//  SparklesManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 23/07/26.
//


//only stars

import UIKit

class SparklesManager {
    static func launch(in view: UIView) {
        let emitter = CAEmitterLayer()
        
        // Fill the screen
        emitter.emitterPosition = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        emitter.emitterSize = view.bounds.size
        emitter.emitterShape = .rectangle
        
        // Additive mode creates the bright "glow" when stars overlap
        emitter.renderMode = .additive
        emitter.zPosition = 999
        
        let star = CAEmitterCell()
        star.contents = drawStar()?.cgImage
        
        // Set the base color to Yellow
        star.color = UIColor.systemYellow.cgColor
        
        // These ranges allow for different shades of gold/yellow for depth
        star.redRange = 0.1
        star.greenRange = 0.1
        
        star.birthRate = 80           // High birth rate for a dense burst
        star.lifetime = 3.0
        star.lifetimeRange = 1.5      // Some last longer than others
        
        star.velocity = 180
        star.velocityRange = 150      // Some fly fast, some drift slowly
        star.emissionRange = .pi * 2  // Explode in all directions
        
        // --- SIZE VARIATION ---
        star.scale = 0.2              // Base size
        star.scaleRange = 0.18         // Varied sizes (from almost 0 to 0.4)
        star.scaleSpeed = 0.02        // Slight growth over time
        
        star.spin = 4
        star.spinRange = 8
        
        star.alphaSpeed = -0.3       // Gentle fade out
        
        emitter.emitterCells = [star]
        view.layer.addSublayer(emitter)
        
        // Burst duration
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            emitter.birthRate = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                emitter.removeFromSuperlayer()
            }
        }
    }
    
    private static func drawStar() -> UIImage? {
        let size = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setFillColor(UIColor.white.cgColor)

        // The 4-pointed sparkle path
        ctx.move(to: CGPoint(x: 25, y: 0))
        ctx.addLine(to: CGPoint(x: 30, y: 20))
        ctx.addLine(to: CGPoint(x: 50, y: 25))
        ctx.addLine(to: CGPoint(x: 30, y: 30))
        ctx.addLine(to: CGPoint(x: 25, y: 50))
        ctx.addLine(to: CGPoint(x: 20, y: 30))
        ctx.addLine(to: CGPoint(x: 0, y: 25))
        ctx.addLine(to: CGPoint(x: 20, y: 20))
        ctx.closePath()
        ctx.fillPath()

        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}



