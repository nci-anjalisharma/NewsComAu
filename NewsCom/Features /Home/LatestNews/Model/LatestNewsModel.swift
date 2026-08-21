//
//  LatestNewsModel.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 21/05/26.
//


struct LatestNewsModel: Codable {

    let status: String
    
    let totalResults: Int
    
    let articles: [Article]
}
