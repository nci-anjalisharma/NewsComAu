//
//  DailyDiscoveryTableViewCell.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/08/26.
//


import UIKit
import SnapKit

final class DailyDiscoveryTableViewCell: UITableViewCell {
    
    private let facts = [

        "There are more possible games of chess than there are atoms in the observable universe.",

        "A single teaspoon of neutron star material would weigh roughly as much as a mountain.",

        "If you shuffled a deck of cards properly, the exact order has probably never existed before in the history of the universe.",

        "Octopuses have three hearts, nine brains, and blue blood.",

        "Sharks are older than trees. Sharks have existed for over 400 million years.",

        "Cleopatra lived closer in time to the invention of the iPhone than to the construction of the Great Pyramid.",

        "The total number of possible ways to arrange a deck of cards is larger than the number of seconds that have passed since the Big Bang.",

        "There may be more trees on Earth than stars in the Milky Way.",

        "A day on Venus is longer than its entire year.",

        "The Eiffel Tower becomes taller in summer because metal expands when heated.",

        "Your body contains atoms that were once inside ancient stars. Many of the elements that make you were forged inside exploding stars.",

        "Lightning can heat the surrounding air to temperatures hotter than the surface of the Sun.",

        "The fingerprints of a koala are so similar to humans that they can sometimes confuse forensic investigators.",

        "Some turtles can breathe through their butts.",

        "A cloud can weigh more than a million pounds.",

        "There are more bacteria living in and on your body than there are people currently alive on Earth.",

        "The human brain can generate enough electrical activity to power a small LED bulb.",

        "Space is not completely silent. Astronauts cannot hear sound directly, but vibrations can still travel through solids.",

        "If you could fold a piece of paper 42 times, its thickness would theoretically reach the Moon.",

        "Honey can remain edible for thousands of years. Archaeologists have found ancient honey that was still preserved.",

        "Wombats produce cube-shaped poop — one of the only known animals to do so.",

        "The average person walks the equivalent of around four times around Earth during their lifetime.",

        "A bolt of lightning is about five times hotter than the surface of the Sun.",

        "Your stomach gets an entirely new lining every few days to stop it from digesting itself.",

        "Bananas are technically berries, but strawberries are not.",

        "The universe contains more stars than there are grains of sand on all of Earth's beaches and deserts combined.",

        "Water can boil and freeze at the same time under the right conditions. This is called the triple point.",

        "The atoms in your left hand may have once been part of a dinosaur, a tree, or even another human.",

        "There is enough DNA in one human body that, if stretched out, it could reach from Earth to Pluto and back many times.",

        "A blue whale's heart is so large that a human could theoretically fit inside one of its major arteries.",

        "The Moon is slowly moving away from Earth at about the same rate that fingernails grow.",

        "There is a species of jellyfish that can revert back to an earlier stage of its life cycle, essentially becoming young again.",

        "If the Sun suddenly disappeared, Earth would continue orbiting normally for about eight minutes before we noticed anything was wrong.",

        "Some of the light you see from distant stars began its journey before humans existed.",

        "You are seeing the Sun as it was about eight minutes ago, not as it is right now.",

        "The observable universe is so vast that there are likely more possible arrangements of atoms than you could ever count, even if you counted for billions of years."
    ]

    static let identifier = "DailyDiscoveryTableViewCell"

    private var isFlipped = false

    // MARK: - Card

    private let card: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 1
        return view
    }()

    // MARK: - Front

    private let iconCircle: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 32
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark.square.fill")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let promptLabel: UILabel = {
        let label = UILabel()
        label.text = "Did you know?"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap to reveal a surprising fact."
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Back

    private let factLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        setupUI()
        applyTheme()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(themeChanged),
            name: .themeChanged,
            object: nil
        )

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(cardTapped)
        )

        card.isUserInteractionEnabled = true
        card.addGestureRecognizer(tapGesture)
    }
    
    func configureRandomFact() {
        factLabel.text = facts.randomElement()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Setup

    private func setupUI() {

        contentView.addSubview(card)

        // Front
        card.addSubview(iconCircle)
        iconCircle.addSubview(iconImageView)
        card.addSubview(promptLabel)
        card.addSubview(subtitleLabel)

        // Back
        card.addSubview(factLabel)

        card.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(6)
        }

        iconCircle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(64)
        }

        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(30)
        }

        promptLabel.snp.makeConstraints {
            $0.top.equalTo(iconCircle.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(promptLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        factLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(28)
        }
    }

    // MARK: - Theme

    @objc private func themeChanged() {
        applyTheme()
    }

    private func applyTheme() {

        let colors = ThemeManager.shared.currentTheme.colors
        let primary = colors.primary

        // Card
        card.backgroundColor = primary.withAlphaComponent(0.06)

        card.layer.borderColor =
            primary.withAlphaComponent(0.15).cgColor

        // Icon
        iconCircle.backgroundColor =
            primary.withAlphaComponent(0.10)

        iconImageView.tintColor = colors.secondary

        // Text
        promptLabel.textColor = primary
        subtitleLabel.textColor = colors.secondary
        factLabel.textColor = primary
    }

    // MARK: - Flip

    @objc private func cardTapped() {

        isFlipped.toggle()

        let fromTransform = card.layer.transform

        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 700.0

        let direction: CGFloat = isFlipped ? 1 : -1

        var rotation = perspective

        rotation = CATransform3DRotate(
            rotation,
            direction * .pi,
            0,
            1,
            0
        )

        // Slightly shrink before flipping
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            options: [.curveEaseOut]
        ) {
            self.card.transform =
                CGAffineTransform(scaleX: 0.94, y: 0.94)
        }

        // Actual 3D flip
        CATransaction.begin()

        CATransaction.setCompletionBlock {

            self.iconCircle.isHidden = self.isFlipped
            self.promptLabel.isHidden = self.isFlipped
            self.subtitleLabel.isHidden = self.isFlipped
            self.factLabel.isHidden = !self.isFlipped

            self.card.layer.transform = CATransform3DIdentity

            UIView.animate(
                withDuration: 0.22,
                delay: 0,
                usingSpringWithDamping: 0.75,
                initialSpringVelocity: 0.5
            ) {
                self.card.transform = .identity
            }
        }

        let animation = CABasicAnimation(
            keyPath: "transform"
        )

        animation.fromValue = fromTransform
        animation.toValue = rotation
        animation.duration = 0.55

        animation.timingFunction =
            CAMediaTimingFunction(name: .easeInEaseOut)

        card.layer.add(
            animation,
            forKey: "cardFlip"
        )

        CATransaction.commit()
    }

    // MARK: - Reuse

    override func prepareForReuse() {

        super.prepareForReuse()

        isFlipped = false

        iconCircle.isHidden = false
        promptLabel.isHidden = false
        subtitleLabel.isHidden = false
        factLabel.isHidden = true

        card.layer.removeAnimation(
            forKey: "cardFlip"
        )

        card.layer.transform = CATransform3DIdentity
        card.transform = .identity

        applyTheme()
    }
}
