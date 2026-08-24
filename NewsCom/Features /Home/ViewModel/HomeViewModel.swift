//
//  HomeViewModel.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 09/04/26.
//

import Foundation

final class HomeViewModel {

    private let apiKey = "35c2604692f54a62bff25d58575b743a"

    var trendingNewsData: TodayTrendingModel?
    var latestNewsData: LatestNewsModel?
    var breakingNewsData: BreakingNews?

    var onDataUpdated: (() -> Void)?

    var trendingArticles: [Article] {
        Array((trendingNewsData?.articles ?? []).prefix(10))
    }

    var latestArticles: [Article] {
//        latestNewsData?.articles ?? []
        Array((latestNewsData?.articles ?? []).prefix(4))
    }

    var breakingArticles: [Article] {
        breakingNewsData?.articles ?? []
    }

    func fetchAllData() {
        fetchTrendingData()
        fetchLatestNewsData()
        fetchBreakingNewsData()
    }


    func fetchTrendingData() {

        let urlString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=\(apiKey)"

        APIManager.shared.fetchNewsData(urlString: urlString) {
            [weak self] (result: Result<TodayTrendingModel, Error>) in

            switch result {

            case .success(let model):

                DispatchQueue.main.async {

                    self?.trendingNewsData = model
                    
                    NewsRepository.shared.trending = Array(model.articles.prefix(10))

                    print("Trending News Fetched")
                    print("Articles Count: \(model.articles.count)")

                    self?.onDataUpdated?()
                }

            case .failure(let error):

                print("Trending News Error")
                print(error.localizedDescription)
            }
        }
    }


    func fetchLatestNewsData() {

        let urlString = "https://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=\(apiKey)"

        APIManager.shared.fetchNewsData(urlString: urlString) {
            [weak self] (result: Result<LatestNewsModel, Error>) in

            switch result {

            case .success(let model):

                DispatchQueue.main.async {

                    self?.latestNewsData = model
                    NewsRepository.shared.latest = model.articles

                    print("Latest News Fetched")
                    print("Articles Count: \(model.articles.count)")

                    self?.onDataUpdated?()
                }

            case .failure(let error):

                print("Latest News Error")
                print(error.localizedDescription)
            }
        }
    }


    func fetchBreakingNewsData() {

        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=\(apiKey)"

        APIManager.shared.fetchNewsData(urlString: urlString) {
            [weak self] (result: Result<BreakingNews, Error>) in

            switch result {

            case .success(let model):

                DispatchQueue.main.async {

                    self?.breakingNewsData = model
                    NewsRepository.shared.breaking = model.articles

                    print("Breaking News Fetched")
                    print("Articles Count: \(model.articles.count)")

                    self?.onDataUpdated?()
                }

            case .failure(let error):

                print("Breaking News Error")
                print(error.localizedDescription)
            }
        }
    }

    func latestArticle(at index: Int) -> Article? {

        guard index < latestArticles.count else {
            return nil
        }

        return latestArticles[index]
    }

    func trendingArticle(at index: Int) -> Article? {

        guard index < trendingArticles.count else {
            return nil
        }

        return trendingArticles[index]
    }

    func breakingArticle(at index: Int) -> Article? {

        guard index < breakingArticles.count else {
            return nil
        }

        return breakingArticles[index]
    }
    
    func randomArticle() -> Article? {
        let articles = trendingArticles + breakingArticles + latestArticles

        return articles.randomElement()
    }
}
