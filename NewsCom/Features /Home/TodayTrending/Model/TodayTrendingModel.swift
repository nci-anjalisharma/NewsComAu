//
//  TodayTrendingModel.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 21/05/26.
//

struct TodayTrendingModel: Codable {

    let status: String
    
    let totalResults: Int
    
    let articles: [Article]
}

