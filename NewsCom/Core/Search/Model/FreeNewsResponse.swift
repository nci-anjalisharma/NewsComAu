//
//  FreeNewsResponse.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 18/08/26.
//

import Foundation

// MARK: - News List

struct FreeNewsResponse: Codable {
    let data: [FreeNewsListArticle]
    let meta: FreeNewsMeta
}

struct FreeNewsListArticle: Codable {
    let uuid: String
    let title: String
    let publishedAt: String
    let publisher: String

    enum CodingKeys: String, CodingKey {
        case uuid
        case title
        case publishedAt = "published_at"
        case publisher
    }
}

// Pagination

struct FreeNewsMeta: Codable {
    let pageSize: Int
    let returned: Int
    let hasMore: Bool
    let orderBy: String
    let offset: Int
    let nextOffset: Int?
    let nextCursor: String?

    enum CodingKeys: String, CodingKey {
        case pageSize = "page_size"
        case returned
        case hasMore = "has_more"
        case orderBy = "order_by"
        case offset
        case nextOffset = "next_offset"
        case nextCursor = "next_cursor"
    }
}

// Details

struct FreeNewsDetailResponse: Codable {
    let data: FreeNewsDetailArticle
}

struct FreeNewsDetailArticle: Codable {
    let uuid: String
    let title: String
    let thumbnail: String?
    let publisher: String?
    let authors: [String]?
    let topics: [String]?
    let countries: [String]?
    let languages: [String]?
    let publishedAt: String?
    let originalURL: String?
    let body: String?

    enum CodingKeys: String, CodingKey {
        case uuid
        case title
        case thumbnail
        case publisher
        case authors
        case topics
        case countries
        case languages
        case publishedAt = "published_at"
        case originalURL = "original_url"
        case body
    }
}
