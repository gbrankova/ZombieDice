//
//  File.swift
//  
//
//  Created by Gabriela Brankova on 10.07.20.
//

import Foundation

/* An abstraction anaglogous to the cup/jar containg
 the dice in the real board game */

struct DiePool {
    typealias Dice = [Die]
    var diceInCup: Dice
    
    init() {
        diceInCup = Array(repeating: Die.GreenDie, count: 6) +
                     Array(repeating: Die.YellowDie, count: 4) +
                     Array(repeating: Die.RedDie, count: 3)
    }
    
    /* Drawing a given number of dice from the cup. The number can vary because
       we may already have 1 or 2 dice in hand (those that rolled to steps from
       the previous throw) */
    mutating func drawDice(howMany number: Int) -> Dice? {
        if diceInCup.capacity < number {
            return nil
        }
        var drawnDice: Dice = []
        for _ in 0..<number {
            drawnDice.append(drawADie())
        }
        return drawnDice
    }
    
    /* Removing the drawn die from the cup.
       If it rolls to brains or shotgun, we should keep it on the board.
       if it rolls to steps, we can choose to reroll it. */
    private mutating func drawADie() -> Die {
        let dieIndex = Int.random(in: 0..<diceInCup.count)
        let drawnDie = diceInCup[dieIndex]
        diceInCup.remove(at: dieIndex)
        return drawnDie
    }
}
