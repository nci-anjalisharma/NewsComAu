//
//  UIImageExtension.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 13/07/26.
//

import UIKit

extension UIImageView {

    func loadImage(from urlString: String) {

        showPlaceholder()
        image = nil
        
        guard
            !urlString.isEmpty,
            let url = URL(string: urlString)
        else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in

            guard
                let self = self,
                let data = data,
                let image = UIImage(data: data)
            else {
                return
            }

            DispatchQueue.main.async {
                self.image = image
                self.hidePlaceholder()
            }
        }.resume()
    }
}

extension UIImageView {

    func addImagePlaceholder() {

        backgroundColor = .systemGray6
        contentMode = .scaleAspectFill
        clipsToBounds = true

        let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .regular)

        let placeholder = UIImageView(image: UIImage(systemName: "photo.on.rectangle.angled", withConfiguration: config))

        placeholder.tag = 999
        placeholder.tintColor = .systemGray3
        placeholder.contentMode = .scaleAspectFit

        addSubview(placeholder)

        placeholder.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([placeholder.centerXAnchor.constraint(equalTo: centerXAnchor), placeholder.centerYAnchor.constraint(equalTo: centerYAnchor), placeholder.widthAnchor.constraint(equalToConstant: 28), placeholder.heightAnchor.constraint(equalToConstant: 28)])
    }

    func showPlaceholder() {
        image = nil
        viewWithTag(999)?.isHidden = false
    }

    func hidePlaceholder() {
        viewWithTag(999)?.isHidden = true
    }
}
