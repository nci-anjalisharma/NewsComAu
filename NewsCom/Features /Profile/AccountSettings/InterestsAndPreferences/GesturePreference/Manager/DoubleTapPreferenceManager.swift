//
//  DoubleTapPreferenceManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 22/07/26.
//


import Foundation

final class DoubleTapPreferenceManager {
    
    static let shared = DoubleTapPreferenceManager()
    
    private init() {}
    
    private let key = "SelectedReadingEffect"
    
    var selectedEffect: ReadingEffect {
        get {
            guard
                let value = UserDefaults.standard.string(forKey: key),
                let effect = ReadingEffect(rawValue: value)
            else {
                return .save
            }
            
            return effect
        }
        
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: key)
        }
    }
}
