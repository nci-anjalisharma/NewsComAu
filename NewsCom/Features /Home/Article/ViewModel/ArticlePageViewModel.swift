//
//  ArticleViewModel.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 21/05/26.
//

//
//import Foundation
//
//class ArticlePageViewModel {
//    
//    
//    //translate
//    
//    private let translationService = TranslationService()
//
//    private(set) var isTranslated = false
//
//    private let originalArticle: Article
//    private(set) var currentArticle: Article
//    
//    //translate
//    
////    private let article: Article
//    
//    init(article: Article) {
////        self.article = article
//        
//        //translate
//        self.originalArticle = article
//        self.currentArticle = article
//    }
//    
//    var imageNmae: String {
//        currentArticle.urlToImage ?? "Article Image"
//    }
//    
//    var headline: String {
//        currentArticle.title ?? "Article Title"
//    }
//    
//    var topic: String {
//        currentArticle.source?.name ?? "Unknown"
//    }
//
////    var content: String {
////        article.content ?? "Article Content"
////    }
//    
////    var content: String {
////
////        let description = article.description ?? ""
////        var content = article.content ?? ""
////
////        // Remove NewsAPI's "[+123 chars]" suffix
////        if let range = content.range(of: " [+") {
////            content = String(content[..<range.lowerBound])
////        }
////
////        let articleBody = """
////        \(description)
////
////        \(content)
////
////        \(description)
////
////        \(content)
////        """
////
////        return articleBody.trimmingCharacters(in: .whitespacesAndNewlines)
////    }
////    
//    var authorName: String {
//        currentArticle.author ?? "Author Name"
//    }
//    
//    var timePublished: String {
//        currentArticle.publishedAt ?? "Date"
//    }
//    
//    enum ArticleLength: String {
//        case short
//        case medium
//        case full
//    }
//    
//    var content: String {
//
//        let description = currentArticle.description ?? ""
//        var content = currentArticle.content ?? ""
//
//        if let range = content.range(of: " [+") {
//            content = String(content[..<range.lowerBound])
//        }
//
//        let body = """
//        \(description)
//
//        \(content)
//        """
//
//        let preference = UserDefaults.standard.string(forKey: "ArticleLength") ?? "medium"
//
//        switch ArticleLength(rawValue: preference) ?? .medium {
//
//        case .short:
//            return body
//
//        case .medium:
//            return """
//
//            \(body) \(body) 
//            
//            \(description)
//            """
//
//        case .full:
//            return """
//
//            \(body) \(body)
//
//            \(body) \(description) \(description)
//            
//            \(description)
//            
//            """
//        }
//    }
//    
//    func translate(to language: TranslationLanguage, completion: @escaping () -> Void) {
//        translationService.translate(article: currentArticle, to: language) { [weak self] translatedArticle in
//
//            self?.currentArticle = translatedArticle
//            self?.isTranslated = true
//
//            completion()
//        }
//    }
//    
//    func restoreOriginal() {
//
//        currentArticle = originalArticle
//        isTranslated = false
//    }
//    
//    func toggleTranslation(to language: TranslationLanguage, completion: @escaping () -> Void) {
//
//        if isTranslated {
//
//            restoreOriginal()
//            completion()
//
//        } else {
//
//            translate(to: language) {
//                completion()
//            }
//        }
//    }
//}
//    
//


//new--
//  ArticlePageViewModel.swift
//  NewsCom
//

import Foundation

final class ArticlePageViewModel {

    private let originalArticle: Article
    private(set) var currentArticle: Article

    private(set) var isTranslated = false
    private(set) var translatedLanguageCode: String?

    init(article: Article) {
        self.originalArticle = article
        self.currentArticle = article
    }

    var imageNmae: String {
        currentArticle.urlToImage ?? "Article Image"
    }

    var headline: String {
        currentArticle.title ?? "Article Title"
    }

    var topic: String {
        currentArticle.source?.name ?? "Unknown"
    }

    var authorName: String {
        currentArticle.author ?? "Author Name"
    }

    var timePublished: String {
        currentArticle.publishedAt ?? "Date"
    }

    enum ArticleLength: String {
        case short
        case medium
        case full
    }

    var content: String {

        let description = currentArticle.description ?? ""

        var content = currentArticle.content ?? ""

        if let range = content.range(of: " [+") {
            content = String(content[..<range.lowerBound])
        }

        let body = """
        \(description)

        \(content)
        """

        let preference =
            UserDefaults.standard.string(forKey: "ArticleLength")
            ?? "medium"

        switch ArticleLength(rawValue: preference) ?? .medium {

        case .short:
            return body

        case .medium:
            return """
            \(body) \(body)

            \(description)
            """

        case .full:
            return """
            \(body) \(body)

            \(body) \(description) \(description)

            \(description)
            """
        }
    }

    func applyTranslation(
        translatedArticle: Article,
        languageCode: String
    ) {
        currentArticle = translatedArticle
        isTranslated = true
        translatedLanguageCode = languageCode
    }

    func restoreOriginal() {
        currentArticle = originalArticle
        isTranslated = false
        translatedLanguageCode = nil
    }
}
