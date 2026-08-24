//
//  BreakingNews.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 12/05/26.
//

struct BreakingNews: Codable {

    let status: String
    
    let totalResults: Int
    
    let articles: [Article]
    
}
