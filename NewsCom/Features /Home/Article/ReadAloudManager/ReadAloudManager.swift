//
//  ReadAloudManager.swift
//  NewsCom
//
//  Created by ANJALI SHARMA R on 30/07/26.
//
import AVFoundation

final class ReadAloudManager: NSObject {

    static let shared = ReadAloudManager()

    private let synthesizer = AVSpeechSynthesizer()
    
    private var totalTextLength: Int = 0

    private override init() {
        super.init()
        synthesizer.delegate = self
    }

    var isSpeaking: Bool {
        synthesizer.isSpeaking
    }

    var isPaused: Bool {
        synthesizer.isPaused
    }
    
    var onProgress: ((Float) -> Void)?

    func speak(text: String) {

        stop()
        
        totalTextLength = text.utf16.count

        onProgress?(0)

        let utterance = AVSpeechUtterance(string: text)

        utterance.rate = 0.48
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        synthesizer.speak(utterance)
    }

    func pause() {
        synthesizer.pauseSpeaking(at: .word)
    }

    func resume() {
        synthesizer.continueSpeaking()
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        onProgress?(0)
    }
}

extension ReadAloudManager: AVSpeechSynthesizerDelegate {

    func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didStart utterance: AVSpeechUtterance
    ) {
        print("Read aloud started")
    }

    func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didFinish utterance: AVSpeechUtterance
    ) {
        print("Read aloud finished")
        onProgress?(1.0)
    }

    func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didPause utterance: AVSpeechUtterance
    ) {
        print("Read aloud paused")
    }

    func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didContinue utterance: AVSpeechUtterance
    ) {
        print("Read aloud resumed")
    }

    func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        didCancel utterance: AVSpeechUtterance
    ) {
        print("Read aloud cancelled")
    }
    
    func speechSynthesizer(
        _ synthesizer: AVSpeechSynthesizer,
        willSpeakRangeOfSpeechString characterRange: NSRange,
        utterance: AVSpeechUtterance
    ) {
        print("🗣️ CALLBACK FIRED")
        print("Range: \(characterRange)")
        print("Text length: \(utterance.speechString.utf16.count)")

        let totalLength = utterance.speechString.utf16.count

        guard totalLength > 0 else {
            return
        }

        let spokenPosition = characterRange.location + characterRange.length

        let progress = Float(spokenPosition) / Float(totalLength)

        print("📍 PROGRESS: \(progress)")

        onProgress?(progress)
    }
}
