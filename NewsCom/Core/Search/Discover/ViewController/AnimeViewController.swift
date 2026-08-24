//
//  AnimeViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/08/26.
//

import UIKit
import SnapKit

final class AnimeViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)

    private var anime: [Anime] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
        loadAnime()
    }

    private func setupUI() {

        view.backgroundColor = .systemBackground
        title = "Anime"
    }

    private func setupTableView() {

        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        tableView.register(AnimeTableViewCell.self, forCellReuseIdentifier: AnimeTableViewCell.identifier)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.separatorStyle = .none
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
    }
    
    private func loadAnime() {

        let animeIDs = ["100", "110", "22", "4", "41"]

        AnimeAPIManager.shared.fetchAnimeList(ids: animeIDs) { [weak self] result in

            switch result {

            case .success(let anime):
                
                self?.anime = anime
                self?.tableView.reloadData()

            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AnimeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        anime.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimeTableViewCell.identifier, for: indexPath) as? AnimeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: anime[indexPath.row])
        return cell
    }
}

extension AnimeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedAnime = anime[indexPath.row]

        let detailVC = AnimeDetailViewController(anime: selectedAnime)

        detailVC.modalPresentationStyle = .pageSheet

        if let sheet = detailVC.sheetPresentationController {

            sheet.detents = [.custom(identifier: .animeDetail) { context in
                    context.maximumDetentValue * 0.75
                }, .large()]

            sheet.selectedDetentIdentifier = .animeDetail

            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 28

            sheet.largestUndimmedDetentIdentifier = .large
        }
        present(detailVC, animated: true)
    }
}

private extension UISheetPresentationController.Detent.Identifier {
    static let animeDetail = Self("animeDetail")
}
