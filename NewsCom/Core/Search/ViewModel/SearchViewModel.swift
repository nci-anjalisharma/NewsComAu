//
//  SearchViewModel.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 16/07/26.
//
import Foundation

final class SearchViewModel {

    private var allArticles: [Article] = []

    var filteredArticles: [Article] = []

    var onResultsUpdated: (() -> Void)?

    func loadArticles() {

        allArticles = NewsRepository.shared.allArticles
        
        filteredArticles = []

        onResultsUpdated?()
    }

    func search(text: String) {
        
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !query.isEmpty else {
            filteredArticles = []
            onResultsUpdated?()
            return
        }

        filteredArticles = allArticles.filter {

            ($0.title?.localizedCaseInsensitiveContains(query) ?? false) || ($0.description?.localizedCaseInsensitiveContains(query) ?? false) || ($0.source?.name?.localizedCaseInsensitiveContains(query) ?? false)
        }
        onResultsUpdated?()
    }
}
