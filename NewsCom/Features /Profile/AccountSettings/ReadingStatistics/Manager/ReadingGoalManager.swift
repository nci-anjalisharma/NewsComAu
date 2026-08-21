//
//  ReadingGoalManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 10/08/26.
//

import UIKit
import Foundation

final class ReadingGoalManager {

    static let shared = ReadingGoalManager()
    
    private let dailyHistoryKey = "dailyReadingHistory"

    private init() {}

    private let dailyGoalKey = "dailyReadingGoal"
//    private let todayMinutesKey = "todayReadingMinutes"
    private let lastDateKey = "readingGoalLastDate"
    private let todaySecondsKey = "todayReadingSeconds"
    
    private let todayArticlesKey = "todayArticlesRead"
    private let yesterdayMinutesKey = "yesterdayReadingMinutes"
    private let totalReadingSecondsKey = "totalReadingSeconds"
    
    var totalReadingSeconds: TimeInterval {
        UserDefaults.standard.double(forKey: totalReadingSecondsKey)
    }
    
    var todaySeconds: TimeInterval {
        resetIfNewDay()

        return UserDefaults.standard.double(forKey: todaySecondsKey)
    }

    var dailyGoal: Int {
        let value = UserDefaults.standard.integer(forKey: dailyGoalKey)

        return value == 0 ? 30 : value
    }

    var todayMinutes: Int {
        resetIfNewDay()

        let seconds = UserDefaults.standard.double(
            forKey: todaySecondsKey
        )

        return Int(seconds / 60)
    }
    
    var todayArticles: Int {
        resetIfNewDay()

        return UserDefaults.standard.integer(forKey: todayArticlesKey)
    }
    
    var percentageChangeFromYesterday: Int {

        let yesterdayMinutes = UserDefaults.standard.integer(forKey: yesterdayMinutesKey)

        guard yesterdayMinutes > 0 else {
            return 0
        }

        let difference = todayMinutes - yesterdayMinutes

        return Int((Double(difference) / Double(yesterdayMinutes)) * 100)
    }

    func setDailyGoal(_ minutes: Int) {
        UserDefaults.standard.set(minutes,forKey: dailyGoalKey)
    }

//    func addReadingTime(_ minutes: Int) {
//        resetIfNewDay()
//
//        let newValue = todayMinutes + minutes
//
//        UserDefaults.standard.set(newValue, forKey: todayMinutesKey)
//    }
//    
    func readingHistoryForGraph() -> [DailyReadingStat] {

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        // Demo data for Monday, Tuesday and Wednesday.
        // These are intentionally fixed for the presentation/demo.
        let demoData: [Int: (minutes: Int, articles: Int)] = [
            2: (18, 3),   // Monday
            3: (32, 5),   // Tuesday
            4: (24, 4)    // Wednesday
        ]

        var result: [DailyReadingStat] = []

        // Sunday -> Saturday / last 7 calendar days
        for offset in stride(from: -6, through: 0, by: 1) {

            guard let date = calendar.date(
                byAdding: .day,
                value: offset,
                to: today
            ) else {
                continue
            }

            let weekday = calendar.component(
                .weekday,
                from: date
            )

            // MARK: - Demo days

            if let demo = demoData[weekday] {

                result.append(
                    DailyReadingStat(
                        date: date,
                        readingMinutes: demo.minutes,
                        readingSeconds: TimeInterval(
                            demo.minutes * 60
                        ),
                        articlesRead: demo.articles
                    )
                )

                continue
            }

            // MARK: - Today = REAL DATA

            if calendar.isDate(
                date,
                inSameDayAs: today
            ) {

                result.append(
                    DailyReadingStat(
                        date: date,
                        readingMinutes: todayMinutes,
                        readingSeconds: todaySeconds,
                        articlesRead: todayArticles
                    )
                )

                continue
            }

            // MARK: - Other days = zero

            result.append(
                DailyReadingStat(
                    date: date,
                    readingMinutes: 0,
                    readingSeconds: 0,
                    articlesRead: 0
                )
            )
        }

        return result
    }
    
    func addReadingTime(seconds: TimeInterval) {

        resetIfNewDay()

        // TODAY ONLY
        let currentTodaySeconds = UserDefaults.standard.double(
            forKey: todaySecondsKey
        )

        let newTodaySeconds = currentTodaySeconds + seconds

        UserDefaults.standard.set(
            newTodaySeconds,
            forKey: todaySecondsKey
        )

        // TOTAL LIFETIME
        let currentTotalSeconds = UserDefaults.standard.double(
            forKey: totalReadingSecondsKey
        )

        let newTotalSeconds = currentTotalSeconds + seconds

        UserDefaults.standard.set(
            newTotalSeconds,
            forKey: totalReadingSecondsKey
        )

        print("TODAY:", newTodaySeconds / 60, "minutes")
        print("TOTAL:", newTotalSeconds / 60, "minutes")

        NotificationCenter.default.post(
            name: .readingTimeChanged,
            object: nil
        )
    }
    
    func recordArticleRead() {
        resetIfNewDay()

        let current = todayArticles

        UserDefaults.standard.set(current + 1, forKey: todayArticlesKey)

        NotificationCenter.default.post(name: .readingTimeChanged, object: nil)
    }
    

    private func resetIfNewDay() {

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        guard let lastDate = UserDefaults.standard.object(
            forKey: lastDateKey
        ) as? Date else {

            // First launch
            UserDefaults.standard.set(today, forKey: lastDateKey)

            return
        }

        let lastDay = calendar.startOfDay(for: lastDate)

        // Still the same day → do nothing
        guard !calendar.isDate(today, inSameDayAs: lastDay) else {
            return
        }

        // MARK: - New day detected

        print("NEW DAY DETECTED")
        print("Previous day:", lastDay)
        print("Current day:", today)

        // Save yesterday's minutes before resetting
        let previousSeconds = UserDefaults.standard.integer(
            forKey: todaySecondsKey
        )
        
        let previousMinutes = Int(previousSeconds / 60)

        UserDefaults.standard.set(
            previousMinutes,
            forKey: yesterdayMinutesKey
        )

        // Save the PREVIOUS day's data
        saveCurrentDayToHistory(date: lastDay)

        UserDefaults.standard.set(
            0,
            forKey: todaySecondsKey
        )

        UserDefaults.standard.set(
            0,
            forKey: todayArticlesKey
        )

        // Update last date
        UserDefaults.standard.set(
            today,
            forKey: lastDateKey
        )

        print("🔄 Daily reading data reset")
    }
    
    private var dailyHistory: [DailyReadingStat] {
        get {
            guard let data = UserDefaults.standard.data(forKey: dailyHistoryKey),
                  let history = try? JSONDecoder().decode(
                    [DailyReadingStat].self,
                    from: data
                  ) else {
                return []
            }

            return history
        }

        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                return
            }

            UserDefaults.standard.set(data, forKey: dailyHistoryKey)
        }
    }
    
    private func saveCurrentDayToHistory(date: Date) {

        let seconds = UserDefaults.standard.double(
            forKey: todaySecondsKey
        )

        let stat = DailyReadingStat(
            date: date,
            readingMinutes: Int(seconds / 60),
            readingSeconds: seconds,
            articlesRead: UserDefaults.standard.integer(
                forKey: todayArticlesKey
            )
        )

        var history = dailyHistory

        // Remove an existing entry for the same day
        history.removeAll {
            Calendar.current.isDate(
                $0.date,
                inSameDayAs: date
            )
        }

        history.append(stat)

        // Most recent days first
        history.sort {
            $0.date > $1.date
        }

        // Keep only the latest 30 days
        history = Array(history.prefix(30))

        dailyHistory = history
    }
    
//    func readingHistoryForGraph() -> [DailyReadingStat] {
//
//        var history = dailyHistory
//
//        let today = DailyReadingStat(
//            date: Calendar.current.startOfDay(for: Date()),
//            readingMinutes: todayMinutes,
//            readingSeconds: todaySeconds,
//            articlesRead: todayArticles
//        )
//
//        history.removeAll {
//            Calendar.current.isDate($0.date, inSameDayAs: today.date)
//        }
//
//        history.append(today)
//
//        return history.sorted {
//            $0.date < $1.date
//        }
//    }
}

extension Notification.Name {
    static let readingTimeChanged = Notification.Name("readingTimeChanged")
}
