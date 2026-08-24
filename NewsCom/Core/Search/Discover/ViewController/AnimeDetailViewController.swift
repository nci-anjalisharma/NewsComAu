//
//  AnimeDetailViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/08/26.
//

import UIKit
import SnapKit

final class AnimeDetailViewController: UIViewController {

    private let anime: Anime

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let animeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()

    private let metadataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    private let genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    private let synopsisTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Synopsis"
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.textColor = .label
        return label
    }()

    private let plotLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    init(anime: Anime) {
        self.anime = anime
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configure()
    }

    private func setupUI() {

        view.backgroundColor = ThemeManager.shared.currentTheme.colors.background

        navigationItem.largeTitleDisplayMode = .never

        view.addSubview(scrollView)

        scrollView.addSubview(contentView)

        contentView.addSubview(animeImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(metadataLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(synopsisTitleLabel)
        contentView.addSubview(plotLabel)

        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        animeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(300)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(animeImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }

        metadataLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
        }

        genresLabel.snp.makeConstraints {
            $0.top.equalTo(metadataLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
        }

        synopsisTitleLabel.snp.makeConstraints {
            $0.top.equalTo(genresLabel.snp.bottom).offset(28)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
        }

        plotLabel.snp.makeConstraints {
            $0.top.equalTo(synopsisTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalTo(titleLabel)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }

    private func configure() {

        titleLabel.text = anime.title

        var metadata: [String] = []

        if let type = anime.type {
            metadata.append(type)
        }

        if let episodes = anime.episodes {
            metadata.append("\(episodes) Episodes")
        }

        metadataLabel.text = metadata.joined(separator: "  •  ")

        genresLabel.text = anime.genres.map { $0.capitalized }.joined(separator: "  •  ")

        plotLabel.text = anime.plotSummary

        loadImage()
    }

    private func loadImage() {

        guard let urlString = anime.imageURL, let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in

            guard let data, error == nil, let image = UIImage(data: data) else {
                return
            }

            DispatchQueue.main.async {
                self?.animeImageView.image = image
            }

        }.resume()
    }
}
