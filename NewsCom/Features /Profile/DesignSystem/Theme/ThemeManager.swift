//
//  ThemeManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 02/06/26.
//

import Foundation

final class ThemeManager {

    static let shared = ThemeManager()

    private init() {}

    private(set) var currentTheme =
        ThemeRepository.modern

    func applyTheme(_ theme: ThemeModel) {

        currentTheme = theme

        saveTheme(theme.id)

        NotificationCenter.default.post(name: .themeChanged, object: nil)
    }

    private func saveTheme(_ id: String) {

        UserDefaults.standard.set(id, forKey: "SelectedTheme")
    }

    func loadTheme() {

        let savedId = UserDefaults.standard.string(forKey: "SelectedTheme")

        switch savedId {

        case "autumn":
            currentTheme = ThemeRepository.autumn

        case "fairytale":
            currentTheme = ThemeRepository.fairytale

        default:
            currentTheme = ThemeRepository.modern
        }
    }
    
}

extension Notification.Name {

    static let themeChanged =
    Notification.Name("themeChanged")
}
