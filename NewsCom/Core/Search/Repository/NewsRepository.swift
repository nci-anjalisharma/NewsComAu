//
//  NewsRepository.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 17/07/26.
//

import Foundation

final class NewsRepository {

    static let shared = NewsRepository()

    private init() {}

    var trending: [Article] = []
    var breaking: [Article] = []
    var latest: [Article] = []
    var explore: [Article] = []

    var allArticles: [Article] {
        let articles = trending + breaking + latest + explore

        var uniqueArticles: [String: Article] = [:]

        for article in articles {
            let key = article.url ?? UUID().uuidString

            if uniqueArticles[key] == nil {
                uniqueArticles[key] = article
            }
        }
        return Array(uniqueArticles.values)
    }
}
