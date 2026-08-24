//
//  Article.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 08/05/26.
//

import UIKit

 
struct Article: Codable {

    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

