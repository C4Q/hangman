//
//  HangmanBrain.swift
//  HangmanApp
//
//  Created by C4Q  on 9/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class HangmanBrain {
    //Public API
    init(targetWord: String) {
        self.targetWord = targetWord
    }
    
    func guessNewCharacter(letter: Character) -> Bool {
        let addedNewChar = guessedLetters.insert(letter).inserted
        if addedNewChar && !targetWord.contains("\(letter)") {
            numberOfIncorrectGuesses += 1
        }
        return addedNewChar
    }
    
    func currentStrToDisplay() -> String {
        var wordToDisplay = targetWord
        for c in targetWord.characters {
            if !guessedLetters.contains(c) {
                wordToDisplay = wordToDisplay.replacingOccurrences(of: "\(c)", with: " _ ")
            }
        }
        return wordToDisplay
    }
    
    func getGameStatus() -> Gamestate {
        let currentHangman = getHangmanStatus()
        if numberOfIncorrectGuesses >= maxIncorrectGuessNumber {
            return .defeat(currentHangman)
        } else if targetWord.characters.reduce(true, {$0 && guessedLetters.contains($1)}) {
            return .victorious(currentHangman)
        } else {
            return .inProgress(currentHangman)
        }
    }
    
    //private implementation
    private func getHangmanStatus() -> Hangman {
        guard let currentHangman = Hangman(rawValue: numberOfIncorrectGuesses) else {
            return Hangman.error
        }
        return currentHangman
    }
    private var targetWord: String
    private var guessedLetters: Set<Character> = []
    private var numberOfIncorrectGuesses = 0
    private let maxIncorrectGuessNumber = 6
}
