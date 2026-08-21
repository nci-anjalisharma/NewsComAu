//
//  DailyReadingStat.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 19/08/26.
//

import Foundation

struct DailyReadingStat: Codable {
    let date: Date
    let readingMinutes: Int
    let readingSeconds: TimeInterval
    let articlesRead: Int
}
