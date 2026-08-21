//
//  ReadingMilestoneManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 28/07/26.
//

import Foundation

final class ReadingMilestoneManager {

    static let shared = ReadingMilestoneManager()

    private init() {}

    let milestones = [5, 10, 15, 20, 25, 30, 35, 40]

    private let completedKey = "CompletedReadingMilestones"

    private var completedMilestones: [Int] {
        get {
            UserDefaults.standard.array(forKey: completedKey) as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: completedKey)
        }
    }

    func checkMilestone(currentCount: Int) -> Int? {

        guard milestones.contains(currentCount) else {
            return nil
        }

        guard !completedMilestones.contains(currentCount) else {
            return nil
        }

        var completed = completedMilestones
        completed.append(currentCount)
        completedMilestones = completed

        return currentCount
    }
    
    func reset() {
        completedMilestones.removeAll()
    }
    
    func unlockedCount() -> Int {
        completedMilestones.count
    }

    func isUnlocked(_ milestone: Int) -> Bool {
        completedMilestones.contains(milestone)
    }

    func remainingArticles(for milestone: Int, currentRead: Int) -> Int {
        max(0, milestone - currentRead)
    }
    
    func allMilestones(currentRead: Int) -> [Milestone] {

        milestones.map { count in

            Milestone(
                articleCount: count,
                title: milestoneTitle(for: count),
                iconName: milestoneIcon(for: count),
                badgeTier: badgeTier(for: count),
                isUnlocked: isUnlocked(count),
                remainingArticles: remainingArticles(for: count,currentRead: currentRead)
            )
        }
    }
    
    private func milestoneTitle(for milestone: Int) -> String {

        switch milestone {

        case 5:
            return "Explorer"

        case 10:
            return "Reader"

        case 15:
            return "News Buff"

        case 20:
            return "Dedicated Reader"

        case 25:
            return "Avid Reader"

        case 30:
            return "News Master"

        case 35:
            return "Milestone 1"

        default:
            return "Milestone 2"
        }
    }


    private func milestoneIcon(for milestone: Int) -> String {

        switch milestone {

        case 5:
            return "book"

        case 10:
            return "books.vertical"

        case 15:
            return "newspaper"

        case 20:
            return "star"

        case 25:
            return "trophy"

        case 30:
            return "crown"

        case 35:
            return "medal"
            
        default:
            return "medal.fill"
        }
    }
    
    private func badgeTier(for milestone: Int) -> BadgeTier? {

        switch milestone {

        case 10:
            return .bronze

        case 20:
            return .silver

        case 30:
            return .gold

        case 40:
            return .platinum

        default:
            return nil
        }
    }
}
