//
//  Milestone.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 28/07/26.
//

import UIKit

struct Milestone {

    let articleCount: Int
    let title: String
    let iconName: String

    let badgeTier: BadgeTier?

    let isUnlocked: Bool
    let remainingArticles: Int
}

enum BadgeTier {
    case bronze
    case silver
    case gold
    case platinum
    case black

    var color: UIColor {
        switch self {

        case .bronze:
            return UIColor(red: 0.72, green: 0.45, blue: 0.2, alpha: 1)

        case .silver:
            return .systemGray

        case .gold:
            return UIColor(red: 1.0, green: 0.75, blue: 0.1, alpha: 1)

        case .platinum:
            return UIColor.systemTeal

        case .black:
            return .black
        }
    }
}
