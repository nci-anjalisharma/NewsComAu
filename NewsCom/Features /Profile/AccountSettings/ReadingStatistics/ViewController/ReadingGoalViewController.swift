//
//  ReadingGoalViewController.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 10/08/26.
//
import UIKit
import SnapKit

final class ReadingGoalViewController: UIViewController {

    // MARK: - Properties

    private var selectedMinutes: Int = 30

    // MARK: - UI

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Daily Reading Goal"
        label.font = UIFont(
            name: "Georgia-Bold",
            size: 32
        ) ?? .boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose a daily time target that fits\nyour intellectual diet."
        label.font = UIFont(name: "Georgia", size: 20) ?? .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private let minutesLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.font = UIFont(name: "Georgia-Bold", size: 40) ?? .systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()

    private let minutesUnitLabel: UILabel = {
        let label = UILabel()
        label.text = "MINUTES"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    private let goalSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 5
        slider.maximumValue = 60
        slider.value = 30
//        slider.backgroundColor = .systemRed
        
        slider.isUserInteractionEnabled = true
        
        return slider
    }()

    private let minimumLabel: UILabel = {
        let label = UILabel()
        label.text = "5m"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()

    private let maximumLabel: UILabel = {
        let label = UILabel()
        label.text = "60m"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .right
        return label
    }()

    private let quickSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "QUICK SELECT"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.attributedText = NSAttributedString(string: "QUICK SELECT", attributes: [.kern: 1.3])
        label.textAlignment = .center
        return label
    }()

    private let lightButton = UIButton(type: .system)
    private let steadyButton = UIButton(type: .system)
    private let deepButton = UIButton(type: .system)

    private let quoteLineView: UIView = {
        let view = UIView()
        return view
    }()

    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.text = "\"Reading is a habit, not a chore.\""
        label.font = UIFont(name: "Georgia-Italic", size: 17) ?? .italicSystemFont(ofSize: 17)
        label.numberOfLines = 1
        return label
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SAVE GOAL", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 10
        return button
    }()

    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let topButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 14
        stack.distribution = .fillEqually
        return stack
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
        setupActions()
        applyTheme()
        loadCurrentGoal()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        goalSlider.backgroundColor = .clear
        goalSlider.isUserInteractionEnabled = true

        print("Slider frame:", goalSlider.frame)
        print("Slider hidden:", goalSlider.isHidden)
        print("Slider alpha:", goalSlider.alpha)
    }

    // MARK: - Setup

    private func setupView() {

        view.backgroundColor = .systemBackground

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)

        view.addSubview(minutesLabel)
        view.addSubview(minutesUnitLabel)

        view.addSubview(goalSlider)
        view.addSubview(minimumLabel)
        view.addSubview(maximumLabel)

        view.addSubview(quickSelectLabel)

//        view.addSubview(lightButton)
//        view.addSubview(steadyButton)
//        view.addSubview(deepButton)
        
        view.addSubview(topButtonsStack)

        topButtonsStack.addArrangedSubview(lightButton)
        topButtonsStack.addArrangedSubview(steadyButton)

        view.addSubview(deepButton)
        //

        view.addSubview(quoteLineView)
        view.addSubview(quoteLabel)

        view.addSubview(saveButton)
        view.addSubview(cancelButton)

        configureQuickSelectButton(lightButton, title: "15m (Light)")

        configureQuickSelectButton(steadyButton, title: "30m (Steady)")

        configureQuickSelectButton(deepButton, title: "45m (Deep)")
    }

    // MARK: - Constraints

    private func setupConstraints() {

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(30)
        }

        // MARK: Minutes

        minutesLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }

        minutesUnitLabel.snp.makeConstraints {
            $0.top.equalTo(minutesLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }

        // MARK: Slider

        goalSlider.snp.makeConstraints {
            $0.top.equalTo(minutesUnitLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(48)
            $0.height.equalTo(20)
        }

        minimumLabel.snp.makeConstraints {
            $0.top.equalTo(goalSlider.snp.bottom).offset(5)
            $0.leading.equalTo(goalSlider)
        }

        maximumLabel.snp.makeConstraints {
            $0.top.equalTo(goalSlider.snp.bottom).offset(5)
            $0.trailing.equalTo(goalSlider)
        }

//        // MARK: Quick Select
//
//        quickSelectLabel.snp.makeConstraints {
//            $0.top.equalTo(minimumLabel.snp.bottom).offset(55)
//            $0.centerX.equalToSuperview()
//        }
//
//        lightButton.snp.makeConstraints {
//            $0.top.equalTo(quickSelectLabel.snp.bottom).offset(22)
//            $0.trailing.equalTo(steadyButton.snp.leading).offset(-12)
//            $0.width.equalTo(140)
//            $0.height.equalTo(48)
//        }
//
//        steadyButton.snp.makeConstraints {
//            $0.top.equalTo(lightButton)
//            $0.centerX.equalToSuperview()
//            $0.width.equalTo(140)
//            $0.height.equalTo(48)
//        }
//
//        deepButton.snp.makeConstraints {
//            $0.top.equalTo(steadyButton.snp.bottom).offset(12)
//            $0.centerX.equalToSuperview()
//            $0.width.equalTo(140)
//            $0.height.equalTo(48)
//        }
        
        quickSelectLabel.snp.makeConstraints {
        $0.top.equalTo(minimumLabel.snp.bottom).offset(55)
        $0.centerX.equalToSuperview()
        }
        
        topButtonsStack.snp.makeConstraints {
            $0.top.equalTo(quickSelectLabel.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(320)
            $0.height.equalTo(48)
        }

        deepButton.snp.makeConstraints {
            $0.top.equalTo(topButtonsStack.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.height.equalTo(48)
        }

        // MARK: Quote

        quoteLineView.snp.makeConstraints {
            $0.top.equalTo(deepButton.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(72)
            $0.width.equalTo(2)
            $0.height.equalTo(38)
        }

        quoteLabel.snp.makeConstraints {
            $0.centerY.equalTo(quoteLineView)
            $0.leading.equalTo(quoteLineView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(20)
        }

        // MARK: Buttons

        saveButton.snp.makeConstraints {
            $0.top.equalTo(quoteLineView.snp.bottom).offset(55)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(60)
        }

        cancelButton.snp.makeConstraints {
            $0.top.equalTo(saveButton.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(60)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    // MARK: - Actions

    private func setupActions() {

        goalSlider.addTarget(
            self,
            action: #selector(sliderChanged),
            for: .valueChanged
        )

        lightButton.addTarget(
            self,
            action: #selector(lightSelected),
            for: .touchUpInside
        )

        steadyButton.addTarget(
            self,
            action: #selector(steadySelected),
            for: .touchUpInside
        )

        deepButton.addTarget(
            self,
            action: #selector(deepSelected),
            for: .touchUpInside
        )

        saveButton.addTarget(
            self,
            action: #selector(saveGoal),
            for: .touchUpInside
        )

        cancelButton.addTarget(
            self,
            action: #selector(cancelGoal),
            for: .touchUpInside
        )
    }

    @objc private func sliderChanged(_ sender: UISlider) {

        let value = Int(sender.value.rounded())

        selectedMinutes = value

        minutesLabel.text = "\(value)"

        updateQuickSelectButtons()
    }

    @objc private func lightSelected() {
        selectGoal(15)
    }

    @objc private func steadySelected() {
        selectGoal(30)
    }

    @objc private func deepSelected() {
        selectGoal(45)
    }

    private func selectGoal(_ minutes: Int) {

        selectedMinutes = minutes

        goalSlider.setValue(Float(minutes), animated: true)

        minutesLabel.text = "\(minutes)"

        updateQuickSelectButtons()
    }

    // MARK: - Save / Cancel

    @objc private func saveGoal() {

        ReadingGoalManager.shared.setDailyGoal(
            selectedMinutes
        )

        NotificationCenter.default.post(
            name: .readingGoalChanged,
            object: nil
        )

        dismiss(animated: true)
    }

    @objc private func cancelGoal() {
        dismiss(animated: true)
    }

    // MARK: - Existing Goal

    private func loadCurrentGoal() {

        let goal = ReadingGoalManager.shared.dailyGoal

        selectedMinutes = goal

        goalSlider.value = Float(goal)
        minutesLabel.text = "\(goal)"

        updateQuickSelectButtons()
    }

    // MARK: - Quick Select

    private func configureQuickSelectButton(
        _ button: UIButton,
        title: String
    ) {

        button.setTitle(
            title,
            for: .normal
        )

        button.titleLabel?.font =
            .systemFont(
                ofSize: 16,
                weight: .medium
            )

        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
    }

    private func updateQuickSelectButtons() {

        let theme =
            ThemeManager.shared.currentTheme

        let buttons: [(UIButton, Int)] = [
            (lightButton, 15),
            (steadyButton, 30),
            (deepButton, 45)
        ]

        buttons.forEach { button, value in

            if selectedMinutes == value {

                button.backgroundColor =
                    theme.colors.primary

                button.setTitleColor(
                    theme.colors.surface,
                    for: .normal
                )

            } else {

                button.backgroundColor =
                    .clear

                button.setTitleColor(
                    theme.colors.secondary,
                    for: .normal
                )
            }
        }
    }

    // MARK: - Theme

    private func applyTheme() {

        let theme =
            ThemeManager.shared.currentTheme

        view.backgroundColor =
            theme.colors.background

        titleLabel.textColor =
            theme.colors.secondary

        subtitleLabel.textColor =
            theme.colors.secondary

        minutesLabel.textColor =
            theme.colors.primary

        minutesUnitLabel.textColor =
            theme.colors.secondary

        minimumLabel.textColor =
            theme.colors.secondary

        maximumLabel.textColor =
            theme.colors.secondary

        quickSelectLabel.textColor =
            theme.colors.secondary
                .withAlphaComponent(0.7)

        quoteLabel.textColor =
            theme.colors.secondary

        quoteLineView.backgroundColor =
            theme.colors.primary

        saveButton.backgroundColor =
            theme.colors.primary

        saveButton.setTitleColor(
            theme.colors.surface,
            for: .normal
        )

        cancelButton.backgroundColor =
            .clear

        cancelButton.setTitleColor(
            theme.colors.primary,
            for: .normal
        )

        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor =
            theme.colors.primary.cgColor

        goalSlider.minimumTrackTintColor =
            theme.colors.primary

        goalSlider.maximumTrackTintColor =
            theme.colors.secondary
                .withAlphaComponent(0.25)

        for button in [lightButton, steadyButton, deepButton] {

            button.layer.borderColor = theme.colors.secondary.withAlphaComponent(0.3).cgColor
        }

        updateQuickSelectButtons()
    }
}
