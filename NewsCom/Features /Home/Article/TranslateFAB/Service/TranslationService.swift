//
//  TranslationService.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 27/07/26.
//

import Foundation

final class TranslationService {

    func translate(
        article: Article,
        to language: TranslationLanguage,
        completion: @escaping (Article) -> Void
    ) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {

            let translatedArticle = Article(
                source: article.source,
                author: article.author,
                title: " \(article.title ?? "")",
                description: "\(article.description ?? "")",
                url: article.url,
                urlToImage: article.urlToImage,
                publishedAt: article.publishedAt,
                content: """
                \(article.content ?? "")
                """
            )

            completion(translatedArticle)
        }
    }
}
