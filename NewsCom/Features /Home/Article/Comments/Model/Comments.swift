//
//  Comments.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 12/08/26.
//


import Foundation

struct Comment: Codable {
    let id: UUID
    let text: String
    let date: Date
}
