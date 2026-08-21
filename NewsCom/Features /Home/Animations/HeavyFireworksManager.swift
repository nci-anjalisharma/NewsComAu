//
//  HeavyFireworksManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 23/07/26.
//

import UIKit


//improved fireworks

final class HeavyFireworksManager {

    static func launch(in view: UIView) {

        // Confetti starts immediately
        createConfetti(in: view)

        // Glitter starts immediately
        createGlitter(in: view)

        // Number of fireworks
        let totalFireworks = 18

        for i in 0..<totalFireworks {

//            let delay = Double(i) * Double.random(in: 0.18...0.35)
            let delay = Double.random(in: 0...3.5)

            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {

                let point = CGPoint(
                    x: CGFloat.random(in: 50...(view.bounds.width - 50)),
                    y: CGFloat.random(in: 80...(view.bounds.height * 0.45))
                )

                launchRocket(to: point, in: view)

                // Random chance of a second explosion nearby
                if Bool.random() {

                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.15...0.35)) {

                        let nearby = CGPoint(
                            x: point.x + CGFloat.random(in: -60...60),
                            y: point.y + CGFloat.random(in: -60...60)
                        )

                        launchRocket(to: nearby, in: view)
                    }
                }
            }
        }
    }
    
    private static func launchRocket(to destination: CGPoint, in view: UIView) {

        let rocket = CALayer()

        rocket.bounds = CGRect(x: 0, y: 0, width: 8, height: 8)
        rocket.cornerRadius = 4
        rocket.backgroundColor = UIColor.white.cgColor

        rocket.shadowColor = UIColor.white.cgColor
        rocket.shadowOpacity = 1
        rocket.shadowRadius = 10
        rocket.shadowOffset = .zero

        let start = CGPoint(
            x: destination.x + CGFloat.random(in: -80...80),
            y: view.bounds.height + 40
        )

        rocket.position = start

        view.layer.addSublayer(rocket)

        createRocketTrail(for: rocket, in: view)

//        CATransaction.begin()
//
//        CATransaction.setCompletionBlock {
//
//            rocket.removeFromSuperlayer()
//
//            let flash = UIView(frame: view.bounds)
//            flash.backgroundColor = .white
//            flash.alpha = 0
//
//            view.addSubview(flash)
//
//            UIView.animate(withDuration: 0.08, animations: {
//                flash.alpha = 0.25
//            }) { _ in
//                UIView.animate(withDuration: 0.25) {
//                    flash.alpha = 0
//                } completion: { _ in
//                    flash.removeFromSuperview()
//                }
//            }
//
//            createFirework(
//                at: destination,
//                in: view
//            )
//        }
//
//        let move = CABasicAnimation(keyPath: "position")
//        move.fromValue = start
//        move.toValue = destination
//        move.duration = Double.random(in: 0.45...0.7)
//        move.timingFunction = CAMediaTimingFunction(name: .easeOut)
//
//        rocket.position = destination
//
//        rocket.add(move, forKey: "rocket")
//
//        CATransaction.commit()
        let duration = Double.random(in: 0.45...0.7)

        let move = CABasicAnimation(keyPath: "position")
        move.fromValue = start
        move.toValue = destination
        move.duration = duration
        move.timingFunction = CAMediaTimingFunction(name: .easeOut)

        rocket.position = destination
        rocket.add(move, forKey: "rocket")

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {

            rocket.removeFromSuperlayer()

            createExplosionFlash(in: view)

            createFirework(at: destination, in: view)
        }
    }
    
    private static func createRocketTrail(
        for rocket: CALayer,
        in view: UIView
    ) {

        let timer = CADisplayLink(target: BlockTarget {

            let sparkle = CALayer()

            let size = CGFloat.random(in: 2...5)

            sparkle.bounds = CGRect(
                x: 0,
                y: 0,
                width: size,
                height: size
            )

            sparkle.cornerRadius = size / 2

            sparkle.position = rocket.presentation()?.position ?? rocket.position

            sparkle.backgroundColor = UIColor.systemYellow.cgColor

            sparkle.shadowColor = UIColor.white.cgColor
            sparkle.shadowRadius = 8
            sparkle.shadowOpacity = 1

            view.layer.addSublayer(sparkle)

            let fade = CABasicAnimation(keyPath: "opacity")
            fade.fromValue = 1
            fade.toValue = 0
            fade.duration = 0.45

            let scale = CABasicAnimation(keyPath: "transform.scale")
            scale.fromValue = 1
            scale.toValue = 0.1
            scale.duration = 0.45

            let group = CAAnimationGroup()
            group.animations = [fade, scale]
            group.duration = 0.45

            sparkle.add(group, forKey: nil)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                sparkle.removeFromSuperlayer()
            }

        }, selector: #selector(BlockTarget.invoke))

        timer.add(to: .main, forMode: .common)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            timer.invalidate()
        }
    }

    private static func createFirework(at center: CGPoint, in view: UIView) {

        let colors: [UIColor] = [
            .systemRed,
            .systemOrange,
            .systemYellow,
            .systemPink,
            .systemPurple,
            .systemBlue,
            .systemGreen,
            .white
        ]

        let rayCount = Int.random(in: 60...80)

        // Explosion pulse
        let pulse = CAShapeLayer()
        pulse.path = UIBezierPath(
            ovalIn: CGRect(x: -6, y: -6, width: 12, height: 12)
        ).cgPath
        pulse.position = center
        pulse.fillColor = UIColor.white.cgColor
        pulse.opacity = 0.8

        view.layer.addSublayer(pulse)

        let pulseScale = CABasicAnimation(keyPath: "transform.scale")
        pulseScale.fromValue = 0
        pulseScale.toValue = 4
        pulseScale.duration = 0.25

        let pulseFade = CABasicAnimation(keyPath: "opacity")
        pulseFade.fromValue = 0.8
        pulseFade.toValue = 0
        pulseFade.duration = 0.3

        let pulseGroup = CAAnimationGroup()
        pulseGroup.animations = [pulseScale, pulseFade]
        pulseGroup.duration = 0.3

        pulse.add(pulseGroup, forKey: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            pulse.removeFromSuperlayer()
        }

        // Firework rays
        for _ in 0..<rayCount {

            let angle = CGFloat.random(in: 0...(2 * .pi))
            let length = CGFloat.random(in: 70...150)

            let path = UIBezierPath()
            path.move(to: .zero)

            // Slight curve instead of perfectly straight
            path.addQuadCurve(
                to: CGPoint(x: length, y: 0),
                controlPoint: CGPoint(
                    x: length * 0.45,
                    y: CGFloat.random(in: -25...25)
                )
            )

            let ray = CAShapeLayer()
            ray.path = path.cgPath
            ray.position = center
            ray.strokeColor = colors.randomElement()!.cgColor
            ray.fillColor = UIColor.clear.cgColor
            ray.lineWidth = CGFloat.random(in: 2...5)
            ray.lineCap = .round

            // Glow
            ray.shadowColor = UIColor.white.cgColor
            ray.shadowOpacity = 1
            ray.shadowRadius = 10
            ray.shadowOffset = .zero

            ray.setAffineTransform(
                CGAffineTransform(rotationAngle: angle)
            )

            view.layer.addSublayer(ray)

            let draw = CABasicAnimation(keyPath: "strokeEnd")
            draw.fromValue = 0
            draw.toValue = 1
            draw.duration = Double.random(in: 0.18...0.28)

            let fade = CABasicAnimation(keyPath: "opacity")
            fade.fromValue = 1
            fade.toValue = 0
            fade.beginTime = 0.25
            fade.duration = Double.random(in: 0.6...1.0)
            fade.fillMode = .forwards
            fade.isRemovedOnCompletion = false

            let scale = CABasicAnimation(keyPath: "transform.scale")
            scale.fromValue = 0.3
            scale.toValue = 1.1
            scale.duration = 0.3

            let group = CAAnimationGroup()
            group.animations = [draw, fade, scale]
            group.duration = 1.2

            ray.add(group, forKey: nil)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                ray.removeFromSuperlayer()
            }
        }

        // Sparkles
        createSparkles(at: center, in: view)

        // Smoke (we'll implement next)
        createSmoke(at: center, in: view)
    }

    private static func createSparkles(at center: CGPoint, in view: UIView) {

        let colors: [UIColor] = [
            .white,
            .systemYellow,
            .systemOrange,
            .systemPink,
            .systemBlue
        ]

        let sparkleCount = Int.random(in: 80...120)

        for _ in 0..<sparkleCount {

            let sparkle = CALayer()

            let size = CGFloat.random(in: 2...5)

            sparkle.bounds = CGRect(x: 0, y: 0, width: size, height: size)
            sparkle.cornerRadius = size / 2
            sparkle.position = center
            sparkle.backgroundColor = colors.randomElement()!.cgColor

            sparkle.shadowColor = UIColor.white.cgColor
            sparkle.shadowRadius = 8
            sparkle.shadowOpacity = 1
            sparkle.shadowOffset = .zero

            view.layer.addSublayer(sparkle)

            let angle = CGFloat.random(in: 0...(2 * .pi))
            let distance = CGFloat.random(in: 50...180)

            let destination = CGPoint(
                x: center.x + cos(angle) * distance,
                y: center.y + sin(angle) * distance
            )

            // Explosion movement
            let move = CABasicAnimation(keyPath: "position")
            move.fromValue = center
            move.toValue = destination
            move.duration = Double.random(in: 0.45...0.7)
            move.timingFunction = CAMediaTimingFunction(name: .easeOut)

            // Gravity (fall after explosion)
            let gravity = CABasicAnimation(keyPath: "position.y")
            gravity.fromValue = destination.y
            gravity.toValue = destination.y + CGFloat.random(in: 80...180)
            gravity.beginTime = move.duration
            gravity.duration = Double.random(in: 0.8...1.3)
            gravity.fillMode = .forwards
            gravity.isRemovedOnCompletion = false
            gravity.timingFunction = CAMediaTimingFunction(name: .easeIn)

            // Twinkle
            let twinkle = CAKeyframeAnimation(keyPath: "opacity")
            twinkle.values = [1, 0.2, 1, 0.3, 1, 0]
            twinkle.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
            twinkle.duration = move.duration + gravity.duration

            // Shrink
            let scale = CABasicAnimation(keyPath: "transform.scale")
            scale.fromValue = 1
            scale.toValue = 0.15
            scale.duration = move.duration + gravity.duration
            scale.fillMode = .forwards
            scale.isRemovedOnCompletion = false

            let group = CAAnimationGroup()
            group.animations = [
                move,
                gravity,
                twinkle,
                scale
            ]
            group.duration = move.duration + gravity.duration

            sparkle.add(group, forKey: nil)

            DispatchQueue.main.asyncAfter(deadline: .now() + group.duration) {
                sparkle.removeFromSuperlayer()
            }
        }
    }
    private static func createSmoke(at center: CGPoint, in view: UIView) {

        let smokeCount = Int.random(in: 8...14)

        for _ in 0..<smokeCount {

            let smoke = CALayer()

            let size = CGFloat.random(in: 12...22)

            smoke.bounds = CGRect(x: 0, y: 0, width: size, height: size)
            smoke.cornerRadius = size / 2

            smoke.position = CGPoint(
                x: center.x + CGFloat.random(in: -8...8),
                y: center.y + CGFloat.random(in: -8...8)
            )

            smoke.backgroundColor = UIColor(
                white: CGFloat.random(in: 0.8...0.95),
                alpha: 0.35
            ).cgColor

            smoke.shadowColor = UIColor.white.cgColor
            smoke.shadowOpacity = 0.3
            smoke.shadowRadius = 8

            view.layer.addSublayer(smoke)

            let move = CABasicAnimation(keyPath: "position")

            move.fromValue = smoke.position

            move.toValue = CGPoint(
                x: smoke.position.x + CGFloat.random(in: -25...25),
                y: smoke.position.y - CGFloat.random(in: 20...50)
            )

            move.duration = Double.random(in: 1.2...2.0)
            move.timingFunction = CAMediaTimingFunction(name: .easeOut)

            let scale = CABasicAnimation(keyPath: "transform.scale")

            scale.fromValue = 0.5
            scale.toValue = CGFloat.random(in: 2.5...4.0)
            scale.duration = move.duration

            let fade = CABasicAnimation(keyPath: "opacity")

            fade.fromValue = 0.35
            fade.toValue = 0
            fade.duration = move.duration

            let group = CAAnimationGroup()
            group.animations = [move, scale, fade]
            group.duration = move.duration
            group.fillMode = .forwards
            group.isRemovedOnCompletion = false

            smoke.add(group, forKey: nil)

            DispatchQueue.main.asyncAfter(deadline: .now() + group.duration) {
                smoke.removeFromSuperlayer()
            }
        }
    }
    private static func createExplosionFlash(in view: UIView) {

        let flash = UIView(frame: view.bounds)
        flash.backgroundColor = .white
        flash.alpha = 0

        view.addSubview(flash)

        UIView.animate(withDuration: 0.08, animations: {
            flash.alpha = 0.25
        }) { _ in
            UIView.animate(withDuration: 0.25) {
                flash.alpha = 0
            } completion: { _ in
                flash.removeFromSuperview()
            }
        }
    }
    
   

    private static func createConfetti(in view: UIView) {

        let emitter = CAEmitterLayer()

        emitter.emitterPosition = CGPoint(
            x: view.bounds.midX,
            y: -20
        )

        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(
            width: view.bounds.width,
            height: 1
        )

        emitter.beginTime = CACurrentMediaTime()

        let colors: [UIColor] = [
            .systemPink,
            .systemBlue,
            .systemGreen,
            .systemOrange,
            .systemYellow,
            .systemPurple,
            .white
        ]

        emitter.emitterCells = colors.map { color in

            let cell = CAEmitterCell()

            cell.birthRate = 7
            cell.lifetime = 7

            cell.velocity = 180
            cell.velocityRange = 70

            cell.emissionRange = .pi

            cell.spin = 5
            cell.spinRange = 4

            cell.scale = 0.12
            cell.scaleRange = 0.08

            cell.color = color.cgColor

            cell.contents = UIImage(
                systemName: "square.fill"
            )?.cgImage

            return cell
        }

        view.layer.addSublayer(emitter)

        removeEmitter(emitter, after: 4)
    }
    
    private static func createGlitter(in view: UIView) {

        let emitter = CAEmitterLayer()

        emitter.emitterPosition = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )

        emitter.emitterShape = .rectangle
        emitter.emitterSize = view.bounds.size

        let cell = CAEmitterCell()

        cell.birthRate = 12
        cell.lifetime = 2.8

        cell.velocity = 25
        cell.velocityRange = 15

        cell.scale = 0.04
        cell.scaleRange = 0.03

        cell.alphaSpeed = -0.4

        cell.contents = UIImage(
            systemName: "sparkle"
        )?.cgImage

        cell.color = UIColor.white.cgColor

        emitter.emitterCells = [cell]

        view.layer.addSublayer(emitter)

        removeEmitter(emitter, after: 4)
    }
    
    private static func randomFireworkLocations(
        in view: UIView
    ) -> [CGPoint] {

        let count = Int.random(in: 12...18)

        return (0..<count).map { _ in

            CGPoint(
                x: CGFloat.random(
                    in: 60...(view.bounds.width - 60)
                ),
                y: CGFloat.random(
                    in: 80...(view.bounds.height * 0.45)
                )
            )
        }
    }
    
    private static func addGlow(to layer: CALayer) {

        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        layer.shadowOffset = .zero
    }

    private static func removeEmitter(
        _ emitter: CAEmitterLayer,
        after duration: TimeInterval
    ) {

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {

            emitter.birthRate = 0

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

                emitter.removeFromSuperlayer()
            }
        }
    }
    
    

}



private final class BlockTarget: NSObject {

    private let block: () -> Void

    init(_ block: @escaping () -> Void) {
        self.block = block
    }

    @objc
    func invoke() {
        block()
    }
}
// 
//        createConfetti(in: view)
//        createGlitter(in: view)
//
//        let totalFireworks = 18
//
//        for _ in 0..<totalFireworks {
//
//            let delay = Double.random(in: 0...4)
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//
//                let point = CGPoint(
//                    x: CGFloat.random(in: 60...(view.bounds.width - 60)),
//                    y: CGFloat.random(in: 80...(view.bounds.height * 0.45))
//                )
//
//                launchRocket(to: point, in: view)
//
//                if Bool.random() {
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.15...0.35)) {
//
//                        let nearby = CGPoint(
//                            x: point.x + CGFloat.random(in: -50...50),
//                            y: point.y + CGFloat.random(in: -50...50)
//                        )
//
//                        launchRocket(to: nearby, in: view)
//                    }
//                }
//            }
//        }
//    }
//
//    private static func launchRocket(
//        to destination: CGPoint,
//        in view: UIView
//    ) {
//
//        let rocket = CALayer()
//
//        rocket.bounds = CGRect(
//            x: 0,
//            y: 0,
//            width: 3,
//            height: 18
//        )
//
//        rocket.cornerRadius = 1.5
//        rocket.backgroundColor = UIColor.white.cgColor
//
//        addGlow(to: rocket)
//
//        let start = CGPoint(
//            x: destination.x + CGFloat.random(in: -80...80),
//            y: view.bounds.height + 30
//        )
//
//        rocket.position = start
//
//        view.layer.addSublayer(rocket)
//
//        createRocketTrail(for: rocket, in: view)
//
//        let duration = Double.random(in: 0.45...0.65)
//
//        let move = CABasicAnimation(keyPath: "position")
//        move.fromValue = start
//        move.toValue = destination
//        move.duration = duration
//        move.timingFunction = CAMediaTimingFunction(name: .easeOut)
//
//        rocket.position = destination
//        rocket.add(move, forKey: nil)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//
//            rocket.removeFromSuperlayer()
//
//            createExplosionFlash(in: view)
//
//            createFirework(
//                at: destination,
//                in: view
//            )
//        }
//    }
//
//    private static func createRocketTrail(
//        for rocket: CALayer,
//        in view: UIView
//    ) {
//
//        let emitter = CAEmitterLayer()
//
//        emitter.emitterShape = .point
//        emitter.emitterPosition = rocket.position
//        emitter.renderMode = .additive
//
//        let cell = CAEmitterCell()
//
//        cell.contents = UIImage(systemName: "circle.fill")?.cgImage
//        cell.birthRate = 90
//        cell.lifetime = 0.45
//
//        cell.velocity = 12
//        cell.velocityRange = 8
//
//        cell.scale = 0.04
//        cell.scaleRange = 0.02
//
//        cell.alphaSpeed = -2.0
//
//        cell.emissionRange = .pi / 10
//
//        cell.color = UIColor.systemYellow.cgColor
//
//        emitter.emitterCells = [cell]
//
//        view.layer.addSublayer(emitter)
//
//        let displayLink = CADisplayLink(target: BlockTarget {
//
//            CATransaction.begin()
//            CATransaction.setDisableActions(true)
//
//            emitter.emitterPosition =
//                rocket.presentation()?.position ?? rocket.position
//
//            CATransaction.commit()
//
//        }, selector: #selector(BlockTarget.invoke))
//
//        displayLink.add(to: .main, forMode: .common)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//
//            displayLink.invalidate()
//
//            emitter.birthRate = 0
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
//
//                emitter.removeFromSuperlayer()
//
//            }
//        }
//    }
//
//    private static func createFirework(
//        at center: CGPoint,
//        in view: UIView
//    ) {
//
//        createExplosionFlash(in: view)
//
//        let pulse = CAShapeLayer()
//        pulse.path = UIBezierPath(
//            ovalIn: CGRect(x: -5, y: -5, width: 10, height: 10)
//        ).cgPath
//        pulse.position = center
//        pulse.fillColor = UIColor.white.cgColor
//
//        view.layer.addSublayer(pulse)
//
//        let pulseGroup = CAAnimationGroup()
//
//        let scale = CABasicAnimation(keyPath: "transform.scale")
//        scale.fromValue = 0
//        scale.toValue = 5
//
//        let fade = CABasicAnimation(keyPath: "opacity")
//        fade.fromValue = 1
//        fade.toValue = 0
//
//        pulseGroup.animations = [scale, fade]
//        pulseGroup.duration = 0.28
//
//        pulse.add(pulseGroup, forKey: nil)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            pulse.removeFromSuperlayer()
//        }
//
//        //-------------------------------------------------
//        // Particle Explosion
//        //-------------------------------------------------
//
//        let emitter = CAEmitterLayer()
//
//        emitter.emitterPosition = center
//        emitter.emitterShape = .point
//        emitter.renderMode = .additive
//
//        let colors: [UIColor] = [
//            .systemRed,
//            .systemOrange,
//            .systemYellow,
//            .systemGreen,
//            .systemBlue,
//            .systemPink,
//            .systemPurple,
//            .white
//        ]
//
//        var cells: [CAEmitterCell] = []
//
//        for color in colors {
//
//            let cell = CAEmitterCell()
//
////            cell.contents = UIImage(systemName: "circle.fill")?.cgImage
//            let image = UIImage(
//                systemName: "sparkle"
//            )?.withTintColor(.white, renderingMode: .alwaysOriginal)
//
//            cell.contents = image?.cgImage
//
//            cell.birthRate = 55
//            cell.lifetime = 1.8
//
//            cell.velocity = 170
//            cell.velocityRange = 90
//
//            cell.yAcceleration = 120
//
//            cell.emissionRange = .pi * 2
//
//            cell.scale = 0.055
//            cell.scaleRange = 0.03
//
//            cell.alphaSpeed = -0.65
//
//            cell.spin = 3
//            cell.spinRange = 4
//
//            cell.color = color.cgColor
//
//            cells.append(cell)
//        }
//
//        emitter.emitterCells = cells
//
//        view.layer.addSublayer(emitter)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
//            emitter.birthRate = 0
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
//            emitter.removeFromSuperlayer()
//        }
//
//        createSmoke(at: center, in: view)
//    }
//
//    private static func createSparkles(at center: CGPoint, in view: UIView) {
//
//        let colors: [UIColor] = [
//            .white,
//            .systemYellow,
//            .systemOrange,
//            .systemPink,
//            .systemBlue
//        ]
//
//        let sparkleCount = Int.random(in: 35...55)
//
//        for _ in 0..<sparkleCount {
//
//            let sparkle = CALayer()
//
//            let size = CGFloat.random(in: 2...5)
//
//            sparkle.bounds = CGRect(x: 0, y: 0, width: size, height: size)
//            sparkle.cornerRadius = size / 2
//            sparkle.position = center
//            sparkle.backgroundColor = colors.randomElement()!.cgColor
//
//            sparkle.shadowColor = UIColor.white.cgColor
//            sparkle.shadowRadius = 8
//            sparkle.shadowOpacity = 1
//            sparkle.shadowOffset = .zero
//
//            view.layer.addSublayer(sparkle)
//
//            let angle = CGFloat.random(in: 0...(2 * .pi))
//            let distance = CGFloat.random(in: 50...180)
//
//            let destination = CGPoint(
//                x: center.x + cos(angle) * distance,
//                y: center.y + sin(angle) * distance
//            )
//
//            // Explosion movement
//            let move = CABasicAnimation(keyPath: "position")
//            move.fromValue = center
//            move.toValue = destination
//            move.duration = Double.random(in: 0.45...0.7)
//            move.timingFunction = CAMediaTimingFunction(name: .easeOut)
//
//            // Gravity (fall after explosion)
//            let gravity = CABasicAnimation(keyPath: "position.y")
//            gravity.fromValue = destination.y
//            gravity.toValue = destination.y + CGFloat.random(in: 80...180)
//            gravity.beginTime = move.duration
//            gravity.duration = Double.random(in: 0.8...1.3)
//            gravity.fillMode = .forwards
//            gravity.isRemovedOnCompletion = false
//            gravity.timingFunction = CAMediaTimingFunction(name: .easeIn)
//
//            // Twinkle
//            let twinkle = CAKeyframeAnimation(keyPath: "opacity")
//            twinkle.values = [1, 0.2, 1, 0.3, 1, 0]
//            twinkle.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
//            twinkle.duration = move.duration + gravity.duration
//
//            // Shrink
//            let scale = CABasicAnimation(keyPath: "transform.scale")
//            scale.fromValue = 1
//            scale.toValue = 0.15
//            scale.duration = move.duration + gravity.duration
//            scale.fillMode = .forwards
//            scale.isRemovedOnCompletion = false
//
//            let group = CAAnimationGroup()
//            group.animations = [
//                move,
//                gravity,
//                twinkle,
//                scale
//            ]
//            group.duration = move.duration + gravity.duration
//
//            sparkle.add(group, forKey: nil)
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + group.duration) {
//                sparkle.removeFromSuperlayer()
//            }
//        }
//    }
//    private static func createSmoke(at center: CGPoint, in view: UIView) {
//
//        let smokeCount = Int.random(in: 4...7)
//
//        for _ in 0..<smokeCount {
//
//            let smoke = CALayer()
//
//            let size = CGFloat.random(in: 12...22)
//
//            smoke.bounds = CGRect(x: 0, y: 0, width: size, height: size)
//            smoke.cornerRadius = size / 2
//
//            smoke.position = CGPoint(
//                x: center.x + CGFloat.random(in: -8...8),
//                y: center.y + CGFloat.random(in: -8...8)
//            )
//
//            smoke.backgroundColor = UIColor(
//                white: CGFloat.random(in: 0.8...0.95),
//                alpha: 0.35
//            ).cgColor
//
//            smoke.shadowColor = UIColor.white.cgColor
//            smoke.shadowOpacity = 0.3
//            smoke.shadowRadius = 8
//
//            view.layer.addSublayer(smoke)
//
//            let move = CABasicAnimation(keyPath: "position")
//
//            move.fromValue = smoke.position
//
//            move.toValue = CGPoint(
//                x: smoke.position.x + CGFloat.random(in: -25...25),
//                y: smoke.position.y - CGFloat.random(in: 20...50)
//            )
//
//            move.duration = Double.random(in: 1.2...2.0)
//            move.timingFunction = CAMediaTimingFunction(name: .easeOut)
//
//            let scale = CABasicAnimation(keyPath: "transform.scale")
//
//            scale.fromValue = 0.5
//            scale.toValue = CGFloat.random(in: 2.5...4.0)
//            scale.duration = move.duration
//
//            let fade = CABasicAnimation(keyPath: "opacity")
//
//            fade.fromValue = 0.35
//            fade.toValue = 0
//            fade.duration = move.duration
//
//            let group = CAAnimationGroup()
//            group.animations = [move, scale, fade]
//            group.duration = move.duration
//            group.fillMode = .forwards
//            group.isRemovedOnCompletion = false
//
//            smoke.add(group, forKey: nil)
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + group.duration) {
//                smoke.removeFromSuperlayer()
//            }
//        }
//    }
//    private static func createExplosionFlash(in view: UIView) {
//
//        let flash = UIView(frame: view.bounds)
//        flash.backgroundColor = .white
//        flash.alpha = 0
//
//        view.addSubview(flash)
//
//        UIView.animate(withDuration: 0.08, animations: {
//            flash.alpha = 0.25
//        }) { _ in
//            UIView.animate(withDuration: 0.25) {
//                flash.alpha = 0
//            } completion: { _ in
//                flash.removeFromSuperview()
//            }
//        }
//    }
//
//
//
//    private static func createConfetti(in view: UIView) {
//
//        let emitter = CAEmitterLayer()
//
//        emitter.emitterPosition = CGPoint(
//            x: view.bounds.midX,
//            y: -20
//        )
//
//        emitter.emitterShape = .line
//        emitter.emitterSize = CGSize(
//            width: view.bounds.width,
//            height: 1
//        )
//
//        emitter.beginTime = CACurrentMediaTime()
//
//        let colors: [UIColor] = [
//            .systemPink,
//            .systemBlue,
//            .systemGreen,
//            .systemOrange,
//            .systemYellow,
//            .systemPurple,
//            .white
//        ]
//
//        emitter.emitterCells = colors.map { color in
//
//            let cell = CAEmitterCell()
//
//            cell.birthRate = 7
//            cell.lifetime = 7
//
//            cell.velocity = 180
//            cell.velocityRange = 70
//
//            cell.emissionRange = .pi
//
//            cell.spin = 5
//            cell.spinRange = 4
//
//            cell.scale = 0.12
//            cell.scaleRange = 0.08
//
//            cell.color = color.cgColor
//
//            cell.contents = UIImage(
//                systemName: "square.fill"
//            )?.cgImage
//
//            return cell
//        }
//
//        view.layer.addSublayer(emitter)
//
//        removeEmitter(emitter, after: 4)
//    }
//
//    private static func createGlitter(in view: UIView) {
//
//        let emitter = CAEmitterLayer()
//
//        emitter.emitterPosition = CGPoint(
//            x: view.bounds.midX,
//            y: view.bounds.midY
//        )
//
//        emitter.emitterShape = .rectangle
//        emitter.emitterSize = view.bounds.size
//
//        let cell = CAEmitterCell()
//
//        cell.birthRate = 12
//        cell.lifetime = 2.8
//
//        cell.velocity = 25
//        cell.velocityRange = 15
//
//        cell.scale = 0.04
//        cell.scaleRange = 0.03
//
//        cell.alphaSpeed = -0.4
//
//        cell.contents = UIImage(
//            systemName: "sparkle"
//        )?.cgImage
//
//        cell.color = UIColor.white.cgColor
//
//        emitter.emitterCells = [cell]
//
//        view.layer.addSublayer(emitter)
//
//        removeEmitter(emitter, after: 4)
//    }
//
//    private static func randomFireworkLocations(
//        in view: UIView
//    ) -> [CGPoint] {
//
//        let count = Int.random(in: 12...18)
//
//        return (0..<count).map { _ in
//
//            CGPoint(
//                x: CGFloat.random(
//                    in: 60...(view.bounds.width - 60)
//                ),
//                y: CGFloat.random(
//                    in: 80...(view.bounds.height * 0.45)
//                )
//            )
//        }
//    }
//
//    private static func addGlow(to layer: CALayer) {
//
//        layer.shadowColor = UIColor.white.cgColor
//        layer.shadowOpacity = 1
//        layer.shadowRadius = 8
//        layer.shadowOffset = .zero
//    }
//
//    private static func removeEmitter(
//        _ emitter: CAEmitterLayer,
//        after duration: TimeInterval
//    ) {
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//
//            emitter.birthRate = 0
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//
//                emitter.removeFromSuperlayer()
//            }
//        }
//    }
//
//
//
//}
//
//private final class BlockTarget: NSObject {
//
//    private let block: () -> Void
//
//    init(_ block: @escaping () -> Void) {
//        self.block = block
//    }
//
//    @objc
//    func invoke() {
//        block()
//    }
//}
//
//
