//
//  TranslationLanguage.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 27/07/26.
//


import Foundation

enum TranslationLanguage: String, CaseIterable {

    case english = "en"
    case spanish = "es"
    case french = "fr"
    case german = "de"
    case italian = "it"
    case portuguese = "pt"

    var title: String {
        switch self {
        case .english: return "English"
        case .spanish: return "Spanish"
        case .french: return "French"
        case .german: return "German"
        case .italian: return "Italian"
        case .portuguese: return "Portuguese"
        }
    }
}
