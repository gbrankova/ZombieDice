//
//  File.swift
//  
//
//  Created by Gabriela Brankova on 10.07.20.
//

import Foundation

struct DiePool {
    typealias Dice = [Die]
    var diceInCup: Dice
    var diceOnBoard: Dice
    
    init() {
        diceInCup = Array(repeating: Die.GreenDie, count: 6) +
                     Array(repeating: Die.YellowDie, count: 4) +
                     Array(repeating: Die.RedDie, count: 2)
        print(diceInCup)
        diceOnBoard = []
    }
    
    mutating func drawDice(howMany number: Int) -> Dice? {
        if diceInCup.capacity < 3 {
            return nil
        }
        let drawnDice: Dice = []
        for i in 0..<number {
            drawnDice.append(drawADie())
        }
        return drawnDice
    }
    
    mutating func putBackDiceInDiceCup() {
        diceInCup += diceOnBoard
        diceOnBoard = []
    }
    
    private mutating func drawADie() -> Die {
        let dieIndex = Int.random(in: 0..<diceInCup.count)
        let drawnDie = diceInCup[dieIndex]
        diceInCup.remove(at: dieIndex)
        diceOnBoard.append(drawnDie)
        return drawnDie
    }
}
