//
//  ReadingStreakManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 10/08/26.
//

import UIKit
import Foundation

final class ReadingStreakManager {

    static let shared = ReadingStreakManager()

    private init() {}

    private let currentStreakKey = "currentStreak"
    private let personalBestKey = "personalBest"
    private let lastReadDateKey = "lastReadDate"

    var currentStreak: Int {
        UserDefaults.standard.integer(forKey: currentStreakKey)
    }

    var personalBest: Int {
        UserDefaults.standard.integer(forKey: personalBestKey)
    }

    private var lastReadDate: Date? {
        UserDefaults.standard.object(forKey: lastReadDateKey) as? Date
    }

    // Call this whenever the user reads an article
    func recordReading() {

        let today = Calendar.current.startOfDay(for: Date())

        guard let lastDate = lastReadDate else {
            setStreak(1, on: today)
            return
        }

        let lastDay = Calendar.current.startOfDay(for: lastDate)

        // Already read today
        if Calendar.current.isDate(today, inSameDayAs: lastDay) {
            return
        }

        // Read yesterday → continue streak
        if let yesterday = Calendar.current.date(
            byAdding: .day,
            value: -1,
            to: today
        ),
        Calendar.current.isDate(lastDay, inSameDayAs: yesterday) {

            let newStreak = currentStreak + 1
            setStreak(newStreak, on: today)

        } else {
            // Missed one or more days → restart
            setStreak(1, on: today)
        }
    }

    private func setStreak(_ streak: Int, on date: Date) {

        UserDefaults.standard.set(streak, forKey: currentStreakKey)
        UserDefaults.standard.set(date, forKey: lastReadDateKey)

        if streak > personalBest {
            UserDefaults.standard.set(streak, forKey: personalBestKey)
        }
    }
}
