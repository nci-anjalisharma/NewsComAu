//
//  ReadingEffect.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 24/07/26.
//


enum ReadingEffect: String, CaseIterable {
    case save
    case confetti
    case hearts
    case fireworks
    case crax
    
    var title: String {
        switch self {
        case .save:
            return "Save Article"
        case .confetti:
            return "Confetti Shower"
        
        case .hearts:
            return "Heart Showers"
            
        case .fireworks:
            return "Fireworks"
        case .crax:
            return "CRAX"
        }
    }
    
    var subtitle: String {
        switch self {
        case .save:
            return "Double-tap to save or remove articles from your Saved collection."
        case .confetti:
            return "Double-tap to release colorful confetti showers while reading."
        case .hearts:
            return "Double-tap to release colorful heart showers while reading."
        case .fireworks:
            return "Double-tap to release colorful fireworks while reading."
        case .crax:
            return "Double-tap to release colorful CRAX while reading."
        }
    }
    
    var iconName: String {
        switch self {
        case .save:
            return "bookmark.fill"
        case .confetti:
            return "wand.and.stars"
        case .hearts:
            return "heart.fill"
        case .fireworks:
            return "sparkles"
        case .crax:
            return "scribble"
            
        }
    }
}
