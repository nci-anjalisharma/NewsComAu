//
//  NicoScene.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 24/07/26.
//

import SpriteKit

final class NicoScene: SKScene {

    enum NicoState {
        case sitting
        case blinking
        case yawning
    }

    private let nico = SKSpriteNode()

    private let sittingSize = CGSize(width: 90, height: 90)

    override func didMove(to view: SKView) {

        backgroundColor = .clear
        scaleMode = .resizeFill

        nico.position = CGPoint(x: size.width / 2, y: size.height / 2)
        nico.name = "nico"

        addChild(nico)

        changeState(.sitting)
        startIdleLoop()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let touch = touches.first else { return }

        let location = touch.location(in: self)

        if nico.contains(location) {
            NotificationCenter.default.post(name: .nicoTapped, object: nil)
        }
    }

    private func changeState(_ state: NicoState) {

        switch state {

        case .sitting:
            nico.texture = SKTexture(imageNamed: "nico_sitting")

        case .blinking:
            nico.texture = SKTexture(imageNamed: "nico_blinking")

        case .yawning:
            nico.texture = SKTexture(imageNamed: "nico_yawning")
        }

        nico.size = sittingSize
    }


    private func startIdleLoop() {

        removeAllActions()

        let delay = Double.random(in: 1.0...2.0)

        run(.sequence([

            .wait(forDuration: delay),

            .run { [weak self] in

                guard let self else { return }

                let random = Int.random(in: 0...99)

                if random < 85 {
                    self.blink()
                } else {
                    self.yawn()
                }
            }
        ]))
    }

    private func blink() {

        changeState(.blinking)

        run(.sequence([

            .wait(forDuration: 0.12),

            .run { [weak self] in
                self?.changeState(.sitting)
            },

            .wait(forDuration: 0.05),

            .run { [weak self] in

                if Int.random(in: 0...9) == 0 {

                    self?.changeState(.blinking)

                    self?.run(.sequence([

                        .wait(forDuration: 0.1),

                        .run {
                            self?.changeState(.sitting)
                        },

                        .run {
                            self?.startIdleLoop()
                        }

                    ]))

                } else {

                    self?.startIdleLoop()
                }
            }
        ]))
    }

    private func yawn() {

        changeState(.yawning)

        run(.sequence([

            .wait(forDuration: 1.2),

            .run { [weak self] in
                self?.changeState(.sitting)
            },

            .wait(forDuration: 0.8),

            .run { [weak self] in
                self?.startIdleLoop()
            }
        ]))
    }
}

extension Notification.Name {
    static let nicoTapped = Notification.Name("nicoTapped")
}
