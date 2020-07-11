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
    
    init() {
        diceInCup = Array(repeating: Die.GreenDie, count: 6) +
                     Array(repeating: Die.YellowDie, count: 4) +
                     Array(repeating: Die.RedDie, count: 2)
    }
    
    mutating func drawDice(howMany number: Int) -> Dice? {
        if diceInCup.capacity < 3 {
            return nil
        }
        var drawnDice: Dice = []
        for _ in 0..<number {
            drawnDice.append(drawADie())
        }
        return drawnDice
    }
    
    mutating func putBackDiceInDiceCup(diceOnBoard dice: Dice) {
        diceInCup += dice
    }
    
    private mutating func drawADie() -> Die {
        let dieIndex = Int.random(in: 0..<diceInCup.count)
        let drawnDie = diceInCup[dieIndex]
        diceInCup.remove(at: dieIndex)
        return drawnDie
    }
}
