//
//  AnimeTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/08/26.
//

import UIKit
import SnapKit

final class AnimeTableViewCell: UITableViewCell {

    static let identifier = "AnimeTableViewCell"

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()

    private let animeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()

    private let genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()

    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()

    private let plotLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 3
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(cardView)

        cardView.addSubview(animeImageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(genresLabel)
        cardView.addSubview(detailsLabel)
        cardView.addSubview(plotLabel)

        cardView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)
        }

        animeImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(190)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(animeImageView.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }

        genresLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
        }

        detailsLabel.snp.makeConstraints {
            $0.top.equalTo(genresLabel.snp.bottom).offset(7)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
        }

        plotLabel.snp.makeConstraints {
            $0.top.equalTo(detailsLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }

    func configure(with anime: Anime) {

        titleLabel.text = anime.title

        genresLabel.text = anime.genres
            .map { $0.capitalized }
            .joined(separator: " • ")

        var details: [String] = []

        if let episodes = anime.episodes {
            details.append("\(episodes) Episodes")
        }

        if let type = anime.type {
            details.append(type)
        }

        detailsLabel.text = details.joined(separator: "  •  ")

        plotLabel.text = anime.plotSummary

        animeImageView.image = nil

        loadImage(from: anime.imageURL)
    }

    private func loadImage(from urlString: String?) {

        guard let urlString, let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

            if let error { return }
            
            guard let data else { return }
            
            guard let image = UIImage(data: data) else { return }

            DispatchQueue.main.async {
                self?.animeImageView.image = image
            }

        }.resume()
    }
}
