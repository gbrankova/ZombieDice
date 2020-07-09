//
//  File.swift
//  
//
//  Created by Gabriela Brankova on 9.07.20.
//

import Foundation

struct ZombieDiceEngine {
    var players: [Player]
    let dice: [Die]
    var currentBrainsScore: Int
    var currentShotgunScore: Int
    
    init() {
        currentBrainsScore = 0
        currentShotgunScore = 0
        dice = Array(repeating: GreenDie(), count: 6) + Array(repeating: YellowDie(), count: 4) + Array(repeating: RedDie(), count: 2)
        players = []
    }
    
    mutating func startGame() {
        var playerCount: Int
        print("#### Welcome to ZombieDice ####")
        print("Please enter the number of players [2-8]: ", terminator: "")
        playerCount = readPlayerNumber()
        readPlayers(playerCount)
    }
        
    func readPlayerNumber() -> Int {
        var playerCount: Int = 0
        var playerCountReady: Bool = false
        
        while !playerCountReady {
            if let count = readLine() {
                if !("2"..."8").contains(count) {
                    print("Player number must be between 2 - 8")
                } else {
                    if let countInt = Int(count) {
                        playerCount = countInt
                        playerCountReady = true
                    } else {
                        print("Player number must be an integer")
                    }
                }
            }
        }
        return playerCount
    }
    
    mutating func readPlayers(_ playerCount: Int) {
        var player: Player
        for i in 1...playerCount {
            player = readPlayer(num: i)
            players.append(player);
        }
    }
    
    func readPlayer(num number: Int) -> Player {
        var playerName: String = ""
        var readNameReady = false

        while !readNameReady {
            print("Please enter a name for player #\(number): ", terminator: "")
            if let name = readLine() {
                playerName = name
                readNameReady = true
            } else {
                print("Invalid name!")
            }
        }
        return Player(name: playerName)
    }
}
