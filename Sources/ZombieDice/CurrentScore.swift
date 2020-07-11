//
//  File.swift
//  
//
//  Created by Gabriela Brankova on 10.07.20.
//

import Foundation

struct CurrentScore {
    var brainsScore = 0
    var shotgunScore = 0
    
    mutating func updateScores(with diceSides: [DieSide]){
        for side in diceSides {
            if (side == DieSide.Brains) {
                brainsScore += 1
            } else if (side == DieSide.Shotgun) {
                shotgunScore += 1
            }
        }
    }
    
    func amIShotguned() -> Bool {
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
