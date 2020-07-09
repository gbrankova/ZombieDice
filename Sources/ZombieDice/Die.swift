//
//  File.swift
//
//
//  Created by Gabriela Brankova on 7.07.20.
//

import Foundation

class Die {
    var sides: [String]
    
    init() {
        self.sides = []
    }
    
    func roll() -> String {
        if let result = sides.randomElement() {
            return result
        }
        return ""
    }
}
