//
//  NicoManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 24/07/26.
//

import UIKit

final class NicoManager {

    static let shared = NicoManager()

    private init() {}

    private var nico: UIImageView?

    func summon(in view: UIView) {

        guard nico == nil else { return }

        let image = UIImage(named: "nico_sit")

        let cat = UIImageView(image: image)

        cat.contentMode = .scaleAspectFit
        cat.frame = CGRect(x: 0, y: 0, width: 90, height: 90)

        nico = cat

        view.addSubview(cat)

        placeRandomly(in: view)
        startBlinking()
    }
}

private extension NicoManager {

    func placeRandomly(in view: UIView) {

        guard let cat = nico else { return }

        let positions = [CGPoint(x: view.bounds.width * 0.25, y: 210), CGPoint(x: view.bounds.width * 0.75, y: 210), CGPoint( x: view.bounds.width * 0.5, y: 420), CGPoint(x: view.bounds.width * 0.8, y: view.bounds.height - 120)]
        
        cat.center = positions.randomElement()!
    }
}

private extension NicoManager {

    func startBlinking() {

        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.blink()
        }
    }

    func blink() {

        guard let cat = nico else { return }
        cat.image = UIImage(named: "nico_blink")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            cat.image = UIImage(named: "nico_sit")
        }
    }
    
    func dismiss() {
        nico?.removeFromSuperview()
        nico = nil
    }
}
