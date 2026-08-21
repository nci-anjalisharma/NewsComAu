//
//  ForYouViewModel.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/08/26.
//
//

final class ForYouViewModel {

    private let apiManager = FreeNewsAPIManager.shared

    private(set) var articles: [FreeNewsListArticle] = []

    var onDataUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?

    func fetchArticles() {

        apiManager.fetchNews(language: "en", country: "us") { [weak self] result in

            guard let self else { return }

            switch result {

            case .success(let response):

                self.articles = response.data
                self.onDataUpdated?()

            case .failure(let error):
                
                self.onError?(error)
            }
        }
    }

    func article(at index: Int) -> FreeNewsListArticle? {

        guard articles.indices.contains(index) else {
            return nil
        }
        return articles[index]
    }

    var numberOfArticles: Int {
        articles.count
    }
}
