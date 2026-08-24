//
//  BookmarkAnimationManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 22/07/26.
//
import UIKit

final class BookmarkAnimationManager {

    static let shared = BookmarkAnimationManager()

    private init() {}

    func play(in view: UIView, from startPoint: CGPoint, to endPoint: CGPoint, saved: Bool, completion: (() -> Void)? = nil) {

        let theme = ThemeManager.shared.currentTheme

        let imageView = UIImageView()
        imageView.image = UIImage(systemName: saved ? "bookmark.fill" : "bookmark")
        imageView.tintColor = saved ? theme.colors.secondary : theme.colors.secondary.withAlphaComponent(0.8)

        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        imageView.center = startPoint

        imageView.alpha = 0
        imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        view.addSubview(imageView)

        UIView.animate(withDuration: 0.22, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.8) {

            imageView.alpha = 1
            imageView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)

        } completion: { _ in

            UIView.animate(withDuration: 0.10) {

                imageView.transform = .identity

            } completion: { _ in

                UIView.animate(withDuration: 0.55, delay: 0, options: [.curveEaseInOut]) {
                    imageView.center = endPoint

                    imageView.alpha = 1

                    imageView.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)

                } completion: { _ in

                    UIView.animate(withDuration: 0.15, animations: {
                        imageView.alpha = 0
                    }, completion: { _ in
                        imageView.removeFromSuperview()
                        completion?()
                    })
                }
            }
        }
    }
}
