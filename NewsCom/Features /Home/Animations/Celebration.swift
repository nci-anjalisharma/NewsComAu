
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







