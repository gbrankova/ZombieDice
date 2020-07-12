//
//  File.swift
//  
//
//  Created by Gabriela Brankova on 11.07.20.
//

import Foundation

struct PlayerTurn {
    var player: Player                    // the player whose turn it is
    var diePool: DiePool                  // jar with dice
    var diceWithStepsOnBoard: [Die]       // dice that rolled to steps and we can
                                          // reroll together with the other dice
                                          // we draw from the diepool
    var currentScore: CurrentScore
    
    var currentDrawnDice: [Die]           // the current 3 dice we have in hand
    var currentDrawnDiceSides : [DieSide] // the die sides we got after rolling
    
    init(player: Player) {
        self.player = player
        self.diePool = DiePool()
        self.currentScore = CurrentScore()
        self.diceWithStepsOnBoard = []
        self.currentDrawnDice = []
        self.currentDrawnDiceSides = []
    }
    
    /* Accepts as an argument the player whose turn it is now.
       Returns whether the player have won or not. */
    mutating func play() -> Bool {
        var endOfTurn = false

        while (!endOfTurn) {
            currentScore.print()
            playDice()
            printRolledDice()
            
            if (currentScore.amIShotgunned()) {
                currentScore.print()
                print("\n💥💥💥 \(player.name) IS SHOTGUNNED! 💥💥💥\n")
                return false
            } else {
                var gotAnAnswerFromPlayer = false
                while (!gotAnAnswerFromPlayer) {
                    print("Do you want to roll again? (yes/no)")
                    
                    if let answer = readLine() {
                        if answer == "no" {
                            currentScore.print()
                            addNewScoreTo()
                            if (player.score >= 13) {
                                print("\n🏅🏅🏅 \(player.name) IS THE WINNER! 🏅🏅🏅\n")
                                return true
                            }
                            endOfTurn = true
                        }
                                                
                        if (answer == "no" || answer == "yes") {
                            gotAnAnswerFromPlayer = true
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
    
    /* A function that puts aside the dice that rolled to steps.
       They may be rerolled on the next throw of the player if he choses so. */
    mutating private func getStepDice() {
        diceWithStepsOnBoard = []
        for index in 0..<currentDrawnDiceSides.count{
            if (currentDrawnDiceSides[index] == DieSide.Steps){
                diceWithStepsOnBoard.append(currentDrawnDice[index])
            }
        }
    }
    
    func addNewScoreTo() {
        player.score += currentScore.brainsScore
    }
    
    /* For each die side we want to give information about the type of die it is a
       side of so that the player come up with a strategy how to play from now on.*/
    func printRolledDice() {
        print("Rolled dice: ", terminator: "")
        for index in 0..<currentDrawnDiceSides.count {
            switch currentDrawnDice[index] {
            case Die.GreenDie:
                print("GreenDie/\(currentDrawnDiceSides[index].rawValue)", terminator: " ")
            case Die.YellowDie:
                print("YellowDie/\(currentDrawnDiceSides[index].rawValue)", terminator: " ")
            case Die.RedDie:
                print("RedDie/\(currentDrawnDiceSides[index].rawValue)", terminator: " ")
            }
        }
        print()
    }
}
