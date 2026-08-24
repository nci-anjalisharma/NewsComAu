//
//  ReadingGraphViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 19/08/26.

import UIKit
import SnapKit

final class ReadingGraphViewController: UIViewController {

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let chartContainer = UIView()
    private let chartView = UIView()
    private let daysStackView = UIStackView()
    private let exploreLabel = UILabel()

    private var stats: [DailyReadingStat] = []

    private let chartHeight: CGFloat = 300
    private let barWidth: CGFloat = 28

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupUI()
        loadReadingData()

        NotificationCenter.default.addObserver(self, selector: #selector(readingDataChanged), name: .readingTimeChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: .themeChanged, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReadingData()
    }

    private func setupNavigationBar() {
        title = "Reading Activity"
        navigationItem.largeTitleDisplayMode = .never
    }

    private func setupUI() {

        let colors = ThemeManager.shared.currentTheme.colors

        view.backgroundColor = colors.background

        titleLabel.text = "Your Reading"
        titleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        titleLabel.textColor = colors.primary

        subtitleLabel.text = "Reading time over the last 7 days"
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.textColor = colors.secondary
        subtitleLabel.numberOfLines = 1

        chartContainer.backgroundColor = colors.secondary.withAlphaComponent(0.06)
        chartContainer.layer.cornerRadius = 24
        chartContainer.clipsToBounds = true

        chartView.backgroundColor = .clear

        chartContainer.addSubview(chartView)

        daysStackView.axis = .horizontal
        daysStackView.distribution = .fillEqually
        daysStackView.alignment = .center
        daysStackView.spacing = 0

        exploreLabel.text = "Reading time · minutes"
        exploreLabel.font = .systemFont(ofSize: 13, weight: .medium)
        exploreLabel.textColor = colors.secondary
        exploreLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(chartContainer)
        view.addSubview(daysStackView)
        view.addSubview(exploreLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalTo(view).inset(24)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.trailing.equalTo(titleLabel)
        }

        chartContainer.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.leading.trailing.equalTo(view).inset(16)
            make.height.equalTo(chartHeight + 40)
        }

        chartView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(chartContainer).inset(20)
            make.top.equalTo(chartContainer).offset(20)
            make.bottom.equalTo(chartContainer).inset(20)
        }

        daysStackView.snp.makeConstraints { make in
            make.top.equalTo(chartContainer.snp.bottom).offset(8)
            make.leading.trailing.equalTo(chartContainer).inset(20)
            make.height.equalTo(28)
        }

        exploreLabel.snp.makeConstraints { make in
            make.top.equalTo(daysStackView.snp.bottom).offset(14)
            make.leading.trailing.equalTo(view).inset(24)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    private func loadReadingData() {

        let allStats = ReadingGoalManager.shared.readingHistoryForGraph()

        let calendar = Calendar.current

        let sortedStats = allStats.sorted { first, second in

            let firstWeekday = calendar.component(.weekday, from: first.date)
            let secondWeekday = calendar.component(.weekday, from: second.date)

            let firstMondayIndex = firstWeekday == 1 ? 7 : firstWeekday - 1

            let secondMondayIndex = secondWeekday == 1 ? 7 : secondWeekday - 1

            return firstMondayIndex < secondMondayIndex
        }

        stats = sortedStats

        for stat in stats {
            print("\(stat.date) - \(stat.readingMinutes)m")
        }
        buildChart()
        buildDayLabels()
    }

    private func buildChart() {

        chartView.subviews.forEach {
            $0.removeFromSuperview()
        }

        guard !stats.isEmpty else {
            return
        }

        let maximumMinutes = max(stats.map {
            $0.readingMinutes
        }.max() ?? 0, 1)

        let colors = ThemeManager.shared.currentTheme.colors

        let availableWidth = UIScreen.main.bounds.width - 72

        let slotWidth = availableWidth / CGFloat(stats.count)

        for (index, stat) in stats.enumerated() {

            let barHeight: CGFloat

            if stat.readingMinutes > 0 {

                let normalized = CGFloat(stat.readingMinutes) / CGFloat(maximumMinutes)

                barHeight = max(normalized * 260, 12)

            } else {
                barHeight = 4
            }

            let barContainer = UIView()

            barContainer.backgroundColor = .clear

            chartView.addSubview(barContainer)

            barContainer.snp.makeConstraints { make in

                make.width.equalTo(slotWidth)
                make.height.equalTo(280)
                make.bottom.equalTo(chartView)
                make.leading.equalTo(chartView).offset(CGFloat(index) * slotWidth)
            }
            
            let bar = UIView()

            bar.backgroundColor = colors.secondary
            bar.layer.cornerRadius = barWidth / 2
            bar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            barContainer.addSubview(bar)

            bar.snp.makeConstraints { make in
                make.width.equalTo(barWidth)
                make.height.equalTo(barHeight)
                make.bottom.equalTo(barContainer)
                make.centerX.equalTo(barContainer)
            }

            let minutesLabel = UILabel()

            minutesLabel.text = "\(stat.readingMinutes)m"
            minutesLabel.font = .systemFont(ofSize: 12, weight: .semibold)
            minutesLabel.textColor = colors.primary
            minutesLabel.textAlignment = .center

            barContainer.addSubview(minutesLabel)

            minutesLabel.snp.makeConstraints { make in
                make.centerX.equalTo(bar)
                make.bottom.equalTo(bar.snp.top).offset(-6)
            }

            bar.transform = CGAffineTransform(scaleX: 1, y: 0.01)

            UIView.animate(withDuration: 0.55, delay: Double(index) * 0.06, usingSpringWithDamping: 0.82, initialSpringVelocity: 0.2, options: [.curveEaseOut]) {

                bar.transform = .identity
            }
        }

        let baseline = UIView()

        baseline.backgroundColor = colors.secondary.withAlphaComponent(0.18)
        chartView.addSubview(baseline)

        baseline.snp.makeConstraints { make in
            make.leading.trailing.equalTo(chartView)
            make.bottom.equalTo(chartView).offset(-1)
            make.height.equalTo(1)
        }
    }
    
    private func buildDayLabels() {

        daysStackView.arrangedSubviews.forEach {
                $0.removeFromSuperview()
            }

        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"

        let colors = ThemeManager.shared.currentTheme.colors

        for stat in stats {

            let label = UILabel()

            label.text = formatter.string(from: stat.date)
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14, weight: .semibold)
            label.textColor = colors.secondary

            daysStackView.addArrangedSubview(label)
        }
    }

    @objc private func readingDataChanged() {
        loadReadingData()
    }

    @objc private func themeChanged() {

        let colors = ThemeManager.shared.currentTheme.colors

        view.backgroundColor =
            colors.background

        titleLabel.textColor =
            colors.primary

        subtitleLabel.textColor =
            colors.secondary

        chartContainer.backgroundColor =
            colors.secondary
                .withAlphaComponent(0.06)

        exploreLabel.textColor =
            colors.secondary

        loadReadingData()
    }

    // MARK: - Cleanup

    deinit {

        NotificationCenter.default.removeObserver(
            self
        )
    }
}
