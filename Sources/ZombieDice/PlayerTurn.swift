//
//  File.swift
//  
//
//  Created by Gabriela Brankova on 11.07.20.
//

import Foundation

struct PlayerTurn {
    var diePool: DiePool
    var diceWithStepsOnBoard: [Die]

    var currentScore: CurrentScore
    
    var currentDrawnDice: [Die]
    var currentDrawnDiceSides : [DieSide]
    
    init() {
        diePool = DiePool()
        currentScore = CurrentScore()
        diceWithStepsOnBoard = []
        currentDrawnDice = []
        currentDrawnDiceSides = []
    }
    
    mutating func play(player: Player) -> Bool {
        var endOfTurn = false

        while (!endOfTurn) {
            currentScore.print()
            playDice()
            printRolledDice()
            
            if (currentScore.amIShotguned()) {
                print("💥💥💥 YOU ARE SHOTGUNNED! 💥💥💥")
                return false
            } else {
                var gotAnAnswerFromPlayer = false
                while (!gotAnAnswerFromPlayer) {
                    print("Do you want to roll again? (yes/no)")
                    
                    if let answer = readLine() {
                        if answer == "no" {
                            addNewScoreTo(player)
                            if (player.score >= 13) {
                                print("🏅🏅🏅 \(player.name) is the winner! 🏅🏅🏅")
                                return true
                            }
                            endOfTurn = true
                        }
                        
                        gotAnAnswerFromPlayer = true
                        
                        if (answer != "no" && answer != "yes") {
                            gotAnAnswerFromPlayer = false
                        }
                    }
                }
            }
        }
        return false
    }
    
    mutating func playDice() {
        rollDice()
        currentScore.updateScores(with: currentDrawnDiceSides)
        getStepDice()
    }
    
    mutating func rollDice() {
        if let dice = diePool.drawDice(howMany: 3 - diceWithStepsOnBoard.count) {

            currentDrawnDice = dice + diceWithStepsOnBoard
            currentDrawnDiceSides = currentDrawnDice.map { $0.rollDie() }
        }
    }
    
    
    mutating private func getStepDice() {
        diceWithStepsOnBoard = []
        for index in 0..<currentDrawnDiceSides.count{
            if (currentDrawnDiceSides[index] == DieSide.Steps){
                diceWithStepsOnBoard.append(currentDrawnDice[index])
            }
        }
    }
    
    func addNewScoreTo(_ player: Player) {
        player.score += currentScore.brainsScore
    }
    
    func printRolledDice() {
        print("Rolled dice: \(currentDrawnDiceSides.map { $0.rawValue })")
    }
}

