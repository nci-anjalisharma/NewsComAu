
//  Created by ANJALI SHARMA R on 27/07/26.
//
//
//  TranslationManager.swift
//  NewsCom
//
//
//import Foundation
//import Translation
//
//final class TranslationManager {
//
//    static let shared = TranslationManager()
//
//    private init() {}
//
//    func translate(
//        text: String,
//        targetLanguageCode: String
//    ) async throws -> String {
//
//        let sourceLanguage = Locale.Language(identifier: "en")
//        let targetLanguage = Locale.Language(
//            identifier: targetLanguageCode
//        )
//
//        let session = TranslationSession(installedSource: sourceLanguage, target: targetLanguage)
//
//        if !session.isReady {
//            try await session.prepareTranslation()
//        }
//
//        let response = try await session.translate(text)
//
//        return response.targetText
//    }
//}
