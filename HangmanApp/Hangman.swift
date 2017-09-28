//
//  Info.swift
//  HangmanApp
//
//  Created by C4Q  on 9/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum Hangman: Int {
    case empty
    case head
    case body
    case leftArm
    case rightArm
    case leftLeg
    case rightLeg
    case error = -1
}

enum Gamestate {
    case notStarted
    case inProgress(Hangman)
    case victorious(Hangman)
    case defeat(Hangman)
}
