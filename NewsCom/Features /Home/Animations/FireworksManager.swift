//
//  FireworksManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 23/07/26.
//

import UIKit

//fireworks

final class FireworksManager {

    static func launch(in view: UIView) {

        let points: [CGPoint] = [
            CGPoint(x: view.bounds.midX, y: 120),                   // Top Centre
            CGPoint(x: 80, y: 180),                                 // Left
            CGPoint(x: view.bounds.width - 80, y: 180),             // Right
            CGPoint(x: 130, y: 320),                                // Lower Left
            CGPoint(x: view.bounds.width - 130, y: 320)             // Lower Right
        ]

        for (index, point) in points.enumerated() {

            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.35) {
                createFirework(at: point, in: view)
            }
        }
    }

    private static func createFirework(at center: CGPoint, in view: UIView) {

        let colors: [UIColor] = [
            .systemRed,
            .systemOrange,
            .systemYellow,
            .systemBlue,
            .systemGreen
        ]

        let rayCount = 32

        for i in 0..<rayCount {

            let angle = CGFloat(i) * (.pi * 2 / CGFloat(rayCount))
            let length = CGFloat.random(in: 55...100)

            let path = UIBezierPath()
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: length, y: 0))

            let ray = CAShapeLayer()
            ray.path = path.cgPath
            ray.position = center
            ray.strokeColor = colors.randomElement()!.cgColor
            ray.lineWidth = CGFloat.random(in: 3...5)
            ray.lineCap = .round

            ray.setAffineTransform(
                CGAffineTransform(rotationAngle: angle)
            )

            view.layer.addSublayer(ray)

            let draw = CABasicAnimation(keyPath: "strokeEnd")
            draw.fromValue = 0
            draw.toValue = 1
            draw.duration = 0.3

            let fade = CABasicAnimation(keyPath: "opacity")
            fade.fromValue = 1
            fade.toValue = 0
            fade.beginTime = 0.35
            fade.duration = 0.8
            fade.fillMode = .forwards
            fade.isRemovedOnCompletion = false

            let group = CAAnimationGroup()
            group.animations = [draw, fade]
            group.duration = 1.15

            ray.add(group, forKey: nil)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                ray.removeFromSuperlayer()
            }
        }
    }
}

