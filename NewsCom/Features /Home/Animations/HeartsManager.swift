//
//  Untitled.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 23/07/26.
//


//Hearts
import UIKit

final class HeartsManager {

    static func launch(in view: UIView) {

        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        emitter.emitterSize = view.bounds.size
        emitter.emitterShape = .rectangle
        emitter.renderMode = .additive
        emitter.zPosition = 999

        let heart = CAEmitterCell()
        heart.contents = heartImage()?.cgImage

        heart.birthRate = 25
        heart.lifetime = 8
        heart.velocity = 180
        heart.velocityRange = 100
        heart.emissionRange = .pi * 2

        heart.scale = 0.18
        heart.scaleRange = 0.08
        heart.spin = 2
        heart.spinRange = 4

        heart.xAcceleration = 20
        heart.yAcceleration = 40
        heart.alphaSpeed = -0.12

        emitter.emitterCells = [heart]
        view.layer.addSublayer(emitter)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            emitter.birthRate = 0

            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                emitter.removeFromSuperlayer()
            }
        }
    }

    private static func heartImage() -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold)

        return UIImage(systemName: "heart.fill", withConfiguration: config)?
            .withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    }
}
