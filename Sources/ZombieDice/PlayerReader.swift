//
//  File.swift
//  
//
//  Created by Gabriela Brankova on 10.07.20.
//

import Foundation

/* This is a struct that contains the logic for reading the information about the
   players and its verification. It creates a correspoding object for each of them.
   It is not possible to create a player with an empty name or to have two or more
   players with the same name. */

struct PlayerReader {
    var players: [Player]
    
    init() {
        players = []
    }
    
    mutating func getPlayers() -> [Player] {
        let playerCount = readPlayerNumber()
        readPlayers(playerCount)
        return players
    }
    
    private func readPlayerNumber() -> Int {
        var playerCount: Int = 0
        var playerCountReady: Bool = false
        
        while !playerCountReady {
            print("Please enter the number of players [2-8]: ", terminator: "")
            if let count = readLine() {
                if (!("2"..."8").contains(count) || count.count != 1) {
                    print("Player number must be an integer between 2 - 8")
                } else {
                    if let countInt = Int(count) {
                        playerCount = countInt
                        playerCountReady = true
                    } else {
                        print("Player number must be an integer between 2 - 8")
                    }
                }
            }
        }
        return playerCount
    }
    
    private mutating func readPlayers(_ playerCount: Int) {
        var player: Player
        for i in 1...playerCount {
            player = readPlayer(number: i)
            players.append(player);
        }
    }
    
    private func readPlayer(number: Int) -> Player {
        var playerName: String = ""
        var readNameReady = false

        while (!readNameReady) {
            print("Please enter a name for player #\(number): ", terminator: "")
            if let name = readLine(), !name.isEmpty, !playerAlreadyExists(with: name) {
                playerName = name
                readNameReady = true
            } else {
                print("Invalid name! Try Again!")
            }
        }
        return Player(name: playerName)
    }
    
    private func playerAlreadyExists(with name: String) -> Bool {
        let playerNames: [String] = players.map {$0.name}
        return playerNames.contains(name)
    }
}
