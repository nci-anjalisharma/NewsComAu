//
//  Untitled.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 28/07/26.
//

import UIKit
import SnapKit

final class MilestonesViewController: UIViewController {

    private let tableView = UITableView()

    private var milestones: [Milestone] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Milestones"
        view.backgroundColor = ThemeManager.shared.currentTheme.colors.background

        setupTableView()
        loadMilestones()
    }


    private func setupTableView() {

        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        tableView.register(ReadingEffectTableViewCell.self, forCellReuseIdentifier: ReadingEffectTableViewCell.identifier)

        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

private extension MilestonesViewController {
    
    private func loadMilestones() {

        let currentRead = ReadingHistoryManager.shared.history.count

        milestones = ReadingMilestoneManager.shared.allMilestones(currentRead: currentRead)
    }
}


extension MilestonesViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        milestones.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: ReadingEffectTableViewCell.identifier, for: indexPath) as! ReadingEffectTableViewCell

        let milestone = milestones[indexPath.row]

        cell.configureMilestone(with: milestone)

        return cell
    }
}
