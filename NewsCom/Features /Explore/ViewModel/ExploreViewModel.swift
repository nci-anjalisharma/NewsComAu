//
//  ExploreViewModel.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 13/07/26.
//

import Foundation

final class ExploreViewModel {

    private let apiKey = "35c2604692f54a62bff25d58575b743a"

    var exploreNewsData: LatestNewsModel?

    var articles: [Article] {
        exploreNewsData?.articles ?? []
    }

    func fetchExploreData(completion: @escaping () -> Void) {

        let urlString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=\(apiKey)"

        APIManager.shared.fetchNewsData(urlString: urlString) {
            [weak self] (result: Result<LatestNewsModel, Error>) in

            switch result {

            case .success(let model):

                DispatchQueue.main.async {

                    self?.exploreNewsData = model
                    NewsRepository.shared.explore = model.articles
                    
                    completion()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func article(at index: Int) -> Article? {

        guard index < articles.count else {
            return nil
        }

        return articles[index]
    }

    var numberOfArticles: Int {
        articles.count
    }
}
