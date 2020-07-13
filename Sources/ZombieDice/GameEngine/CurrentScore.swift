//
//  File.swift
//  
//
//  Created by Gabriela Brankova on 10.07.20.
//

import Foundation

/* An abstraction that encapsulates
 information about a player's score
 during his current turn. */
struct CurrentScore {
    var brainsScore: Int = 0
    var shotgunScore: Int = 0
    
    mutating func updateScores(with diceSides: [DieSide]){
        for side in diceSides {
            if (side == DieSide.Brains) {
                brainsScore += 1
            } else if (side == DieSide.Shotgun) {
                shotgunScore += 1
            }
        }
    }
    
    func amIShotgunned() -> Bool {
        return shotgunScore >= 3
    }
    
    mutating func resetScore() {
        brainsScore = 0
        shotgunScore = 0
    }
    
    func print() {
        Swift.print("--- Current score ---")
        Swift.print("🧠: \(brainsScore),💥: \(shotgunScore)")
    }
}
