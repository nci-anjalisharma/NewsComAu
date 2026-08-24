//
//  ReadAloudPlayerView.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 04/08/26.
//
//
//  ReadAloudPlayerView.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 04/08/26.
//

import UIKit
import SnapKit

final class ReadAloudPlayerView: UIView {

    // MARK: - UI

    private let glassView: UIVisualEffectView = {

        if #available(iOS 26.0, *) {
            let effect = UIGlassEffect(style: .clear)
            return UIVisualEffectView(effect: effect)
        } else {
            let effect = UIBlurEffect(style: .systemUltraThinMaterial)
            return UIVisualEffectView(effect: effect)
        }
    }()

    private let speakerButton: UIButton = {

        let button = UIButton(type: .system)

        button.setImage(
            UIImage(
                systemName: "speaker.wave.2.fill",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 16,
                    weight: .semibold
                )
            ),
            for: .normal
        )

        button.tintColor = ThemeManager.shared.currentTheme.colors.secondary

        return button
    }()

    private let expandedView: UIView = {

        let view = UIView()
        view.backgroundColor = .clear

        return view
    }()

    private let playPauseButton: UIButton = {

        let button = UIButton(type: .system)

        button.setImage(
            UIImage(
                systemName: "pause.fill",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 17,
                    weight: .semibold
                )
            ),
            for: .normal
        )

        button.tintColor = ThemeManager.shared.currentTheme.colors.secondary

        return button
    }()

    private let closeButton: UIButton = {

        let button = UIButton(type: .system)

        button.setImage(
            UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 16,
                    weight: .semibold
                )
            ),
            for: .normal
        )

        button.tintColor = ThemeManager.shared.currentTheme.colors.secondary

        return button
    }()

    // MARK: - Properties

    private var isExpanded = false
    private var isPlaying = false
    private var isPaused = false

    var onStart: (() -> Void)?
    var onStop: (() -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupActions()
        setupPanGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI

    private func setupUI() {

        backgroundColor = .clear

        layer.cornerRadius = 20
        layer.masksToBounds = true

        layer.borderWidth = 1
        layer.borderColor =
            ThemeManager.shared.currentTheme.colors.secondary
                .withAlphaComponent(0.5)
                .cgColor

        addSubview(glassView)

        glassView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        glassView.contentView.addSubview(speakerButton)

        speakerButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupActions() {

        speakerButton.addTarget(
            self,
            action: #selector(speakerTapped),
            for: .touchUpInside
        )

        playPauseButton.addTarget(
            self,
            action: #selector(playPauseTapped),
            for: .touchUpInside
        )

        closeButton.addTarget(
            self,
            action: #selector(closeTapped),
            for: .touchUpInside
        )
    }

    // MARK: - Speaker

    @objc
    private func speakerTapped() {

        guard !isExpanded else { return }

        print("🔊 Speaker tapped")

        isPlaying = true
        isPaused = false

        setPlayPauseIcon(isPlaying: true)

        expand()

        onStart?()
    }

    // MARK: - Play / Pause

    @objc
    private func playPauseTapped() {

        let manager = ReadAloudManager.shared

        if isPlaying && !isPaused {

            print("⏸ Pausing speech")

            manager.pause()

            isPaused = true

            setPlayPauseIcon(isPlaying: false)

        } else if isPlaying && isPaused {

            print("▶️ Resuming speech")

            manager.resume()

            isPaused = false

            setPlayPauseIcon(isPlaying: true)
        }
    }

    private func setPlayPauseIcon(isPlaying: Bool) {

        let imageName = isPlaying
            ? "pause.fill"
            : "play.fill"

        let image = UIImage(
            systemName: imageName,
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: 17,
                weight: .semibold
            )
        )

        playPauseButton.setImage(
            image,
            for: .normal
        )
    }

    // MARK: - Close

    @objc
    private func closeTapped() {

        print("⏹ Closing read aloud")

        ReadAloudManager.shared.stop()

        isPlaying = false
        isPaused = false

        collapse()

        onStop?()
    }

    // MARK: - Expand

    private func expand() {

        guard !isExpanded else { return }

        isExpanded = true

        speakerButton.isHidden = true

        glassView.contentView.addSubview(expandedView)

        expandedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        expandedView.addSubview(playPauseButton)
        expandedView.addSubview(closeButton)

        playPauseButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }

        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
        }

        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: [.curveEaseInOut]
        ) {

            self.snp.updateConstraints {
                $0.width.equalTo(112)
            }

            self.superview?.layoutIfNeeded()
        }
    }

    // MARK: - Collapse

    private func collapse() {

        guard isExpanded else { return }

        isExpanded = false
        isPlaying = false
        isPaused = false

        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: [.curveEaseInOut]
        ) {

            self.snp.updateConstraints {
                $0.width.equalTo(56)
            }

            self.superview?.layoutIfNeeded()

        } completion: { _ in

            self.expandedView.removeFromSuperview()

            self.speakerButton.isHidden = false

            self.setPlayPauseIcon(isPlaying: false)
        }
    }
}

// MARK: - Pan Gesture

extension ReadAloudPlayerView {

    private func setupPanGesture() {

        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePan(_:))
        )

        panGesture.delegate = self
        panGesture.cancelsTouchesInView = false

        addGestureRecognizer(panGesture)
    }

    @objc
    private func handlePan(
        _ gesture: UIPanGestureRecognizer
    ) {

        guard let superview = superview else {
            return
        }

        let translation =
            gesture.translation(in: superview)

        center = CGPoint(
            x: center.x + translation.x,
            y: center.y + translation.y
        )

        gesture.setTranslation(
            .zero,
            in: superview
        )

        if gesture.state == .ended ||
            gesture.state == .cancelled {

            snapToNearestEdge()
        }
    }

    private func snapToNearestEdge() {

        guard let superview = superview else {
            return
        }

        let horizontalPadding: CGFloat = 20
        let verticalPadding: CGFloat = 20

        let leftX =
            horizontalPadding + bounds.width / 2

        let rightX =
            superview.bounds.width
            - horizontalPadding
            - bounds.width / 2

        let targetX: CGFloat

        if center.x < superview.bounds.midX {
            targetX = leftX
        } else {
            targetX = rightX
        }

        let minY =
            superview.safeAreaInsets.top
            + bounds.height / 2
            + verticalPadding

        let maxY =
            superview.bounds.height
            - superview.safeAreaInsets.bottom
            - bounds.height / 2
            - verticalPadding

        let targetY =
            min(
                max(center.y, minY),
                maxY
            )

        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: [.curveEaseOut]
        ) {

            self.center = CGPoint(
                x: targetX,
                y: targetY
            )
        }
    }
}

// MARK: - Gesture Delegate

extension ReadAloudPlayerView: UIGestureRecognizerDelegate {

    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {

        true
    }
}
