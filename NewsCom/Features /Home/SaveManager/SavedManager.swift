//
//  SaveManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 03/06/26.
//


import UIKit

class SavedManager {
    
    static let shared = SavedManager()
    
    private init() { }
    
    private let key = "saved_articles"
    
    func save(_ article: Article) {
        
        var articles = fetchSavedArticles()
        
        guard !articles.contains(where: { $0.url == article.url }) else {
            return
        }
        
        articles.append(article)
        
        if let data = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(data, forKey: key)
        }
        
        NotificationCenter.default.post(name: .savedArticlesChanged, object: nil)
    }
        
    func remove(_ article: Article) {
            
        var articles = fetchSavedArticles()
            
        articles.removeAll {
            $0.url == article.url
        }
            
        if let data = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(data, forKey: key)
        }
        
        NotificationCenter.default.post(name: .savedArticlesChanged, object: nil)
    }
        
    func fetchSavedArticles() -> [Article] {
            
        guard let data = UserDefaults.standard.data(forKey: key),
            let articles = try? JSONDecoder().decode([Article].self, from: data)
        else {
            return []
        }
        return articles
    }
        
    func isSaved(_ article: Article) -> Bool {
            
        fetchSavedArticles().contains {
            $0.url == article.url
        }
    }
    
    func savedArticlesCount() -> Int {
        return fetchSavedArticles().count
    }
    
    func clearAllSavedArticles() {

        UserDefaults.standard.removeObject(forKey: key)

        NotificationCenter.default.post(
            name: .savedArticlesChanged,
            object: nil
        )
    }
}

extension Notification.Name {
    static let savedArticlesChanged = Notification.Name("savedArticlesChanged")
    
    static let readingHistoryChanged = Notification.Name("readingHistoryChanged")
}
