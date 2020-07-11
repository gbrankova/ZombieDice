//
//  File.swift
//
//
//  Created by Gabriela Brankova on 7.07.20.
//

import Foundation

enum DieSide: String {
    case Brains = "🧠"
    case Steps = "👣"
    case Shotgun = "💥"
}

enum Die {
    case GreenDie
    case YellowDie
    case RedDie
    
    var sides: [DieSide] {
        switch self {
        case .GreenDie:
            return Array(repeating: DieSide.Brains, count: 3) +
                   Array(repeating: DieSide.Steps, count: 2) +
                   Array(repeating: DieSide.Shotgun, count: 1)
        case .YellowDie:
            return Array(repeating: DieSide.Brains, count: 2) +
                   Array(repeating: DieSide.Steps, count: 2) +
                   Array(repeating: DieSide.Shotgun, count: 2)
        case .RedDie:
            return Array(repeating: DieSide.Brains, count: 1) +
                   Array(repeating: DieSide.Steps, count: 2) +
                   Array(repeating: DieSide.Shotgun, count: 3)
        }
    }
    
    func rollDie() -> DieSide {
        return sides.randomElement()!
    }
}

