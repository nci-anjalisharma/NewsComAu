//
//  DailyGoalCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 31/07/26.
//

import UIKit
import SnapKit

final class ReadingGoalCell: UITableViewCell {

    static let identifier = "ReadingGoalCell"
    
    var onSetGoalTapped: (() -> Void)?

    // MARK: - UI Elements

    private let cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "READING GOALS"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.attributedText = NSAttributedString(
            string: "READING GOALS",
            attributes: [.kern: 1.0]
        )
        return label
    }()

    private let setGoalButton: UIButton = {
        let button = UIButton(type: .system)

        button.setTitle("SET GOAL", for: .normal)

        button.titleLabel?.font = .systemFont(
            ofSize: 13,
            weight: .semibold
        )

        button.titleLabel?.adjustsFontSizeToFitWidth = false
        button.titleLabel?.lineBreakMode = .byClipping
        
        button.addTarget(self, action: #selector(setGoalTapped), for: .touchUpInside)

        return button
        
    }()
    
    @objc private func setGoalTapped() {
        onSetGoalTapped?()
    }

    // Circular progress
    private let progressBackgroundView = UIView()

    private let progressLayer = CAShapeLayer()
    private let backgroundProgressLayer = CAShapeLayer()

    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let goalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Init

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        setupView()
        setupConstraints()
        applyTheme()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(themeChanged),
            name: .themeChanged,
            object: nil
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {

        contentView.addSubview(cardView)

        cardView.addSubview(titleLabel)
        cardView.addSubview(setGoalButton)
        cardView.addSubview(progressBackgroundView)
        cardView.addSubview(percentageLabel)
        cardView.addSubview(goalLabel)

        progressBackgroundView.layer.addSublayer(
            backgroundProgressLayer
        )

        progressBackgroundView.layer.addSublayer(
            progressLayer
        )
    }

    // MARK: - Constraints

    private func setupConstraints() {

        cardView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(22)
        }

        setGoalButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(22)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }

        progressBackgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(120)
        }

        percentageLabel.snp.makeConstraints {
            $0.center.equalTo(progressBackgroundView)
        }

        goalLabel.snp.makeConstraints {
            $0.top.equalTo(progressBackgroundView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(22)
        }
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()

        setupProgressCircle()
    }

    private func setupProgressCircle() {

        let center = CGPoint(x: progressBackgroundView.bounds.midX, y: progressBackgroundView.bounds.midY)

        let radius: CGFloat = 70

        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + (CGFloat.pi * 2)

        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )

        backgroundProgressLayer.path = path.cgPath
        backgroundProgressLayer.fillColor = UIColor.clear.cgColor
        backgroundProgressLayer.lineWidth = 10
        backgroundProgressLayer.lineCap = .butt

        progressLayer.path = path.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 10
        progressLayer.lineCap = .butt

        updateProgressAppearance()
    }

    // MARK: - Configuration

    func configure(currentMinutes: Int, dailyGoal: Int) {

        let progress: CGFloat

        if dailyGoal > 0 {
            progress = min(CGFloat(currentMinutes) / CGFloat(dailyGoal), 1.0)
        } else {
            progress = 0
        }

        let percentage = Int(progress * 100)

        percentageLabel.text = "\(percentage)%"

        goalLabel.text = "\(currentMinutes) / \(dailyGoal) minutes daily goal"

        updateProgress(progress: progress)
    }

    private func updateProgress(progress: CGFloat = 0) {

        progressLayer.strokeEnd = progress
        updateProgressAppearance()
    }

    // MARK: - Theme

    private func updateProgressAppearance() {

        let theme = ThemeManager.shared.currentTheme

        backgroundProgressLayer.strokeColor = theme.colors.secondary.withAlphaComponent(0.15).cgColor

        progressLayer.strokeColor = theme.colors.primary.cgColor
    }

    private func applyTheme() {

        let theme = ThemeManager.shared.currentTheme

        cardView.backgroundColor = theme.colors.surface

        cardView.layer.borderColor = theme.colors.primary.cgColor

        titleLabel.textColor = theme.colors.secondary

        setGoalButton.setTitleColor(theme.colors.primary, for: .normal)

        percentageLabel.textColor = theme.colors.primary

        goalLabel.textColor = theme.colors.secondary

        updateProgressAppearance()
    }

    @objc private func themeChanged() {
        applyTheme()
    }

    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()

        percentageLabel.text = nil
        goalLabel.text = nil

        progressLayer.strokeEnd = 0
    }

    // MARK: - Deinit

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
