//
//  ReadingHistory.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 14/05/26.
//

import Foundation

final class ReadingHistoryManager {

    static let shared = ReadingHistoryManager()

    private let key = "readingHistory"

    private(set) var history: [Article] = []

    private init() {
        load()
    }

    func add(_ article: Article) {

        history.removeAll {
            $0.url == article.url
        }

        history.insert(article, at: 0)

        save()
    }

    private func save() {

        guard let data = try? JSONEncoder().encode(history) else {
            return
        }
        
        UserDefaults.standard.set(data, forKey: key)
    }

    private func load() {

        guard let data = UserDefaults.standard.data(forKey: key),
              let articles = try? JSONDecoder().decode([Article].self, from: data)
        else {
            return
        }
        history = articles
    }
    
    func clearHistory() {

        history.removeAll()       

        UserDefaults.standard.removeObject(forKey: key)
        
        ReadingMilestoneManager.shared.reset()

        NotificationCenter.default.post(name: .readingHistoryChanged, object: nil)
    }
}

