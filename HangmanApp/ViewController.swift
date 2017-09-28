//
//  ViewController.swift
//  HangmanApp
//
//  Created by C4Q  on 9/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var brain: HangmanBrain?
    
    @IBOutlet weak var headView: UIImageView!
    @IBOutlet weak var bodyView: UIImageView!
    @IBOutlet weak var leftArmView: UIImageView!
    @IBOutlet weak var rightArmView: UIImageView!
    @IBOutlet weak var leftLegView: UIImageView!
    @IBOutlet weak var rightLegView: UIImageView!
    var hangmanViews: [UIImageView] = []
    
    @IBOutlet weak var newWordEntryLabel: UITextField!
    @IBOutlet weak var guessesLabel: UITextField!
    @IBOutlet weak var wordDisplayLabel: UILabel!

    @IBOutlet weak var gameOverLabel: UILabel!
    
    @IBAction func startGameButtonPressed(_ sender: UIButton) {
        if let newWord = newWordEntryLabel.text {
            brain = HangmanBrain(targetWord: newWord)
        } else {
            brain = HangmanBrain(targetWord: "testing")
        }
        updateImage(hangman: Hangman(rawValue: 0)!)
        newWordEntryLabel.text = ""
        guessesLabel.text = ""
        wordDisplayLabel.text = brain?.currentStrToDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImages()
        brain = HangmanBrain(targetWord: "testing")
        wordDisplayLabel.text = brain!.currentStrToDisplay()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard range.length == 0 else {
            return false
        }
        guard let brain = brain else {
            return true
        }
        guard let finalLetter = Array(string.characters).last else {
            return true
        }
        let userGuessedNewChar = brain.guessNewCharacter(letter: finalLetter)
        wordDisplayLabel.text = brain.currentStrToDisplay()
        let currentStatus = brain.getGameStatus()
        switch currentStatus {
        case .inProgress(let hangman):
            updateImage(hangman: hangman)
        case .defeat(let hangman):
            updateImage(hangman: hangman)
            didLoseGame()
        case .victorious(let hangman):
            updateImage(hangman: hangman)
            didWinGame()
        default:
            break
        }
        return userGuessedNewChar
    }
    
    func updateImage(hangman: Hangman) {
        for i in 0..<hangman.rawValue {
            hangmanViews[i].isHidden = false
        }
    }
    
    func didWinGame() {
        self.view.backgroundColor = .green
        gameOverLabel.text = "VICTORY"
        gameOverLabel.isHidden = false
    }
    
    func didLoseGame() {
        self.view.backgroundColor = .red
        gameOverLabel.text = "DEFEAT"
        gameOverLabel.isHidden = false
    }
    
    func setupImages() {
        headView.image = #imageLiteral(resourceName: "Head")
        bodyView.image = #imageLiteral(resourceName: "Body")
        leftArmView.image = #imageLiteral(resourceName: "LeftArm")
        rightArmView.image = #imageLiteral(resourceName: "RightArm")
        leftLegView.image = #imageLiteral(resourceName: "LeftLeg")
        rightLegView.image = #imageLiteral(resourceName: "RightLeg")
        hangmanViews = [headView, bodyView, leftArmView, rightArmView, leftLegView, rightLegView]
        hangmanViews.forEach{$0.isHidden = true}
    }
}

