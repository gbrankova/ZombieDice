//
//  File.swift
//
//
//  Created by Gabriela Brankova on 9.07.20.
//

// An abstraction of a virtual player that contains its name and score

class Player {
    var name: String
    var score: Int
    
    init(name: String, score: Int = 0) {
        self.name = name
        self.score = score
    }
    
    func resetScore() {
        score = 0
    }
}
