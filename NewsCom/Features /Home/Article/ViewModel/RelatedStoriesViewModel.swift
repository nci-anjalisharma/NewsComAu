//
//  RelatedStoriesViewModel.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 25/05/26.
//

import Foundation

class RelatedStoriesViewModel {

    private(set) var relatedArticles: [Article]

    init(articles: [Article]) {
        self.relatedArticles = articles
    }

    var count: Int {
        relatedArticles.count
    }

    func article(at index: Int) -> Article? {

        guard index >= 0, index < relatedArticles.count else {
            return nil
        }

        return relatedArticles[index]
    }
}
