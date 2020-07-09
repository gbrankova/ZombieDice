//
//  File.swift
//
//
//  Created by Gabriela Brankova on 7.07.20.
//

import Foundation

class YellowDie: Die {
    override init() {
        super.init()
        sides = Array(repeating: "🧠", count: 2) + Array(repeating: "👣", count: 2) + Array(repeating: "💥", count: 2)
    }
}
