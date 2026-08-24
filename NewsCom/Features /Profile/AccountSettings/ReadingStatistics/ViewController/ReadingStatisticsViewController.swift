//
//  Topic1ViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 15/04/26.
//


import UIKit
import SnapKit

final class ReadingStatisticsViewController: UIViewController {


    private let tableView = UITableView(frame: .zero, style: .plain)
    
    let streakManager = ReadingStreakManager.shared


    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
        setupConstraints()
        
        navigationItem.title = "Reading Statistics"
        
        setupNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
        
    }
    
    private func setupNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(readingGoalChanged), name: .readingGoalChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(readingTimeDidChange), name: .readingTimeChanged, object: nil)

    }
    
    
    @objc private func readingGoalChanged() {
        tableView.reloadData()
    }
    
    @objc private func readingTimeDidChange() {
        tableView.reloadData()
    }

    private func setupView() {
        view.backgroundColor = ThemeManager.shared.currentTheme.colors.background
    }

    private func setupTableView() {
         
        let theme = ThemeManager.shared.currentTheme
        
        tableView.backgroundColor = theme.colors.background

        tableView.separatorStyle = .none

        tableView.showsVerticalScrollIndicator = false

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(TotalReadingTimeCell.self, forCellReuseIdentifier: TotalReadingTimeCell.identifier)

        tableView.register(ReadingStreakCell.self,forCellReuseIdentifier: ReadingStreakCell.identifier)

        tableView.register(ReadingGoalCell.self, forCellReuseIdentifier: ReadingGoalCell.identifier)

        view.addSubview(tableView)
    }

    private func setupConstraints() {

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// UITableViewDataSource

extension ReadingStatisticsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {

        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TotalReadingTimeCell.identifier, for: indexPath) as! TotalReadingTimeCell

            let manager = ReadingGoalManager.shared

            let totalSeconds = manager.totalReadingSeconds + 4440 
            

            let hours = Int(totalSeconds) / 3600
            let minutes = (Int(totalSeconds) % 3600) / 60

            let readingTime: String

            if hours > 0 {
                readingTime = "\(hours)h \(minutes)m"
            } else {
                readingTime = "\(minutes)m"
            }

            cell.configure(readingTime: readingTime, articles: ReadingHistoryManager.shared.history.count, percentageChange: manager.percentageChangeFromYesterday)

            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReadingStreakCell.identifier,for: indexPath) as! ReadingStreakCell
            
            cell.configure(currentStreak: ReadingStreakManager.shared.currentStreak, personalBest: ReadingStreakManager.shared.personalBest)

            return cell

//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: WeeklyActivityCell.identifier, for: indexPath) as! WeeklyActivityCell
//
//            return cell
//
//        case 3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ReadingInsightCell.identifier, for: indexPath) as! ReadingInsightCell
//
//            return cell
//
//        case 4:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ReadingTopicsCell.identifier,for: indexPath) as! ReadingTopicsCell
//
//            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReadingGoalCell.identifier, for: indexPath) as! ReadingGoalCell
            
            cell.configure(currentMinutes: ReadingGoalManager.shared.todayMinutes, dailyGoal: ReadingGoalManager.shared.dailyGoal)
            
            cell.onSetGoalTapped = { [weak self] in

                let vc = ReadingGoalViewController()

                vc.modalPresentationStyle = .pageSheet

                self?.present(vc, animated: true)
            }

            return cell

//        case 6:
//            let cell = tableView.dequeueReusableCell(withIdentifier: ReadingConsistencyCell.identifier, for: indexPath) as! ReadingConsistencyCell
//
//            return cell

        default:
            fatalError("Unexpected row")
        }
    }
}


//  UITableViewDelegate

extension ReadingStatisticsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
