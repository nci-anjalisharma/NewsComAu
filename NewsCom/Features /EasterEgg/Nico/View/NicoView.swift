//
//  NicoView.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 24/07/26.
//

import UIKit
import SpriteKit
import SnapKit

final class NicoView: UIView {

    private let spriteView = SKView()
    
    private let scene = NicoScene(size: CGSize(width: 120, height: 120))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        let scenePoint = scene.convertPoint(fromView: point)
        
        return scene.atPoint(scenePoint) == scene.childNode(withName: "nico")
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setup() {

        backgroundColor = .clear

        addSubview(spriteView)

        spriteView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        spriteView.backgroundColor = .clear
        spriteView.allowsTransparency = true
        spriteView.ignoresSiblingOrder = true
        spriteView.isUserInteractionEnabled = false

        scene.backgroundColor = .clear

        spriteView.presentScene(scene)
    }
}
