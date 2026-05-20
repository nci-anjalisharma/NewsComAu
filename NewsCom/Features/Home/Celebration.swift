//import UIKit
//
// 
//
//
////honestly don't know what it is but its huge and colorful
//
//class CelebrationManager {
//    static func launch(in view: UIView) {
//        let emitter = CAEmitterLayer()
//        emitter.emitterPosition = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
//        emitter.emitterShape = .rectangle
//        emitter.emitterSize = view.bounds.size
//        
//        // 1. Organic Ribbon Confetti
//        let confetti = createCell(content: .ribbon)
//        confetti.redRange = 0.8
//        confetti.greenRange = 0.8
//        confetti.blueRange = 0.8 // Randomizes colors
//        confetti.velocity = 200
//        confetti.yAcceleration = 180
//        
//        // 2. Rising Balloons
//        let balloon = createCell(content: .balloon)
//        balloon.scale = 0.5
//        balloon.velocity = 120
//        balloon.yAcceleration = -80
//        balloon.emissionLongitude = 0
//        
//        // 3. Pro Sparkles (Twinkling stars)
//        let sparkle = createCell(content: .sparkle)
//        sparkle.birthRate = 10
//        sparkle.velocity = 60
//        sparkle.scale = 0.1
//        sparkle.scaleRange = 0.1
//        sparkle.alphaSpeed = -0.4
//        // This creates the "pulsing" twinkle effect
//        sparkle.scaleSpeed = 0.2
//        
//        emitter.emitterCells = [confetti, balloon, sparkle]
//        view.layer.addSublayer(emitter)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
//            emitter.birthRate = 0
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
//                emitter.removeFromSuperlayer()
//            }
//        }
//    }
//
//    private static func createCell(content: ShapeType) -> CAEmitterCell {
//        let cell = CAEmitterCell()
//        cell.birthRate = 15
//        cell.lifetime = 4.0
//        cell.velocityRange = 100
//        cell.emissionRange = .pi * 2
//        cell.spin = 4
//        cell.spinRange = 4
//        cell.contents = drawShape(content)?.cgImage
//        return cell
//    }
//
//    enum ShapeType { case ribbon, balloon, sparkle }
//
//    private static func drawShape(_ type: ShapeType) -> UIImage? {
//        let size = CGSize(width: 60, height: 60)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
//        
//        UIColor.white.setFill()
//        
//        switch type {
//        case .ribbon:
//            // A curved ribbon shape
//            let path = UIBezierPath()
//            path.move(to: CGPoint(x: 10, y: 10))
//            path.addCurve(to: CGPoint(x: 40, y: 40), controlPoint1: CGPoint(x: 50, y: 0), controlPoint2: CGPoint(x: 0, y: 50))
//            path.lineWidth = 8
//            path.lineCapStyle = .round
//            UIColor.white.setStroke()
//            path.stroke()
//            
//        case .balloon:
//            // Ovoid balloon with a little "string" nub
//            let path = UIBezierPath(ovalIn: CGRect(x: 15, y: 5, width: 30, height: 40))
//            path.fill()
//            let triangle = UIBezierPath()
//            triangle.move(to: CGPoint(x: 30, y: 45))
//            triangle.addLine(to: CGPoint(x: 25, y: 55))
//            triangle.addLine(to: CGPoint(x: 35, y: 55))
//            triangle.fill()
//            
//        case .sparkle:
//            // 4-pointed star (Glow style)
//            let center = CGPoint(x: 30, y: 30)
//            for i in 0..<4 {
//                let path = UIBezierPath(ovalIn: CGRect(x: 28, y: 0, width: 4, height: 60))
//                ctx.saveGState()
//                ctx.translateBy(x: center.x, y: center.y)
//                ctx.rotate(by: CGFloat(i) * .pi / 2)
//                ctx.translateBy(x: -center.x, y: -center.y)
//                path.fill()
//                ctx.restoreGState()
//            }
//        }
//        
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image
//    }
//}




//star-balloon-confetti

import UIKit

class CelebrationManager {
    enum CelebrationShape { case rect, circle, star }

    static func launch(in view: UIView) {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        emitter.emitterSize = view.bounds.size
        emitter.emitterShape = .rectangle
        
        // This makes the stars "glow" and look professional
        emitter.renderMode = .additive
        emitter.zPosition = 999
        
        let colors: [UIColor] = [.systemPink, .systemBlue, .systemGreen, .systemYellow, .systemPurple, .systemOrange]
        var allCells: [CAEmitterCell] = []
        
        for color in colors {
            // 1. Confetti (Falling)
            let confetti = createCell(shape: .rect)
            confetti.color = color.cgColor
            confetti.birthRate = 12
            confetti.yAcceleration = 250
            confetti.emissionLongitude = .pi
            allCells.append(confetti)
            
            // 2. Balloons (Rising)
            let balloon = createCell(shape: .circle)
            balloon.color = color.cgColor
            balloon.birthRate = 3
            balloon.velocity = 150
            balloon.yAcceleration = -120
            balloon.emissionLongitude = 0
            balloon.scale = 0.4
            allCells.append(balloon)
        }
        
        // 3. Stars (Sparkling / Twinkling)
        let star = createCell(shape: .star)
        star.color = UIColor.systemYellow.cgColor
        star.birthRate = 25
        star.velocity = 120
        star.emissionRange = .pi * 2
        star.alphaSpeed = -0.3
        star.scaleSpeed = 0.1
        allCells.append(star)
        
        emitter.emitterCells = allCells
        view.layer.addSublayer(emitter)
        
        // Burst for 0.8 seconds then stop spawning
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            emitter.birthRate = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                emitter.removeFromSuperlayer()
            }
        }
    }
    
    private static func createCell(shape: CelebrationShape) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.lifetime = 4.0
        cell.velocityRange = 100
        cell.emissionRange = .pi / 4
        cell.spin = 4
        cell.spinRange = 4
        cell.scale = 0.15
        cell.scaleRange = 0.1
        cell.contents = drawShape(shape)?.cgImage
        return cell
    }

    private static func drawShape(_ shape: CelebrationShape) -> UIImage? {
        let size = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setFillColor(UIColor.white.cgColor)

        switch shape {
        case .rect:
            ctx.fill(CGRect(x: 15, y: 10, width: 20, height: 30))
        case .circle:
            ctx.fillEllipse(in: CGRect(x: 10, y: 5, width: 30, height: 40))
        case .star:
            // Sharp 4-pointed glint path
            ctx.move(to: CGPoint(x: 25, y: 0))      // Top
            ctx.addLine(to: CGPoint(x: 30, y: 20))
            ctx.addLine(to: CGPoint(x: 50, y: 25))  // Right
            ctx.addLine(to: CGPoint(x: 30, y: 30))
            ctx.addLine(to: CGPoint(x: 25, y: 50))  // Bottom
            ctx.addLine(to: CGPoint(x: 20, y: 30))
            ctx.addLine(to: CGPoint(x: 0, y: 25))   // Left
            ctx.addLine(to: CGPoint(x: 20, y: 20))
            ctx.closePath()
            ctx.fillPath()
        }

        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

//
////only stars
//
//import UIKit
//
//class CelebrationManager {
//    static func launch(in view: UIView) {
//        let emitter = CAEmitterLayer()
//        
//        // Fill the screen
//        emitter.emitterPosition = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
//        emitter.emitterSize = view.bounds.size
//        emitter.emitterShape = .rectangle
//        
//        // Additive mode creates the bright "glow" when stars overlap
//        emitter.renderMode = .additive
//        emitter.zPosition = 999
//        
//        let star = CAEmitterCell()
//        star.contents = drawStar()?.cgImage
//        
//        // Set the base color to Yellow
//        star.color = UIColor.systemYellow.cgColor
//        
//        // These ranges allow for different shades of gold/yellow for depth
//        star.redRange = 0.1
//        star.greenRange = 0.1
//        
//        star.birthRate = 80           // High birth rate for a dense burst
//        star.lifetime = 3.0
//        star.lifetimeRange = 1.5      // Some last longer than others
//        
//        star.velocity = 180
//        star.velocityRange = 150      // Some fly fast, some drift slowly
//        star.emissionRange = .pi * 2  // Explode in all directions
//        
//        // --- SIZE VARIATION ---
//        star.scale = 0.2              // Base size
//        star.scaleRange = 0.18         // Varied sizes (from almost 0 to 0.4)
//        star.scaleSpeed = 0.02        // Slight growth over time
//        
//        star.spin = 4
//        star.spinRange = 8
//        
//        star.alphaSpeed = -0.3       // Gentle fade out
//        
//        emitter.emitterCells = [star]
//        view.layer.addSublayer(emitter)
//        
//        // Burst duration
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            emitter.birthRate = 0
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
//                emitter.removeFromSuperlayer()
//            }
//        }
//    }
//    
//    private static func drawStar() -> UIImage? {
//        let size = CGSize(width: 50, height: 50)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        let ctx = UIGraphicsGetCurrentContext()!
//        ctx.setFillColor(UIColor.white.cgColor)
//
//        // The 4-pointed sparkle path
//        ctx.move(to: CGPoint(x: 25, y: 0))
//        ctx.addLine(to: CGPoint(x: 30, y: 20))
//        ctx.addLine(to: CGPoint(x: 50, y: 25))
//        ctx.addLine(to: CGPoint(x: 30, y: 30))
//        ctx.addLine(to: CGPoint(x: 25, y: 50))
//        ctx.addLine(to: CGPoint(x: 20, y: 30))
//        ctx.addLine(to: CGPoint(x: 0, y: 25))
//        ctx.addLine(to: CGPoint(x: 20, y: 20))
//        ctx.closePath()
//        ctx.fillPath()
//
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return img
//    }
//}
