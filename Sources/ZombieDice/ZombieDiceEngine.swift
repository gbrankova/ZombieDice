//
//  File.swift
//  
//
//  Created by Gabriela Brankova on 9.07.20.
//

import Foundation

struct ZombieDiceEngine {
    var players: [Player]
    var whoseTurnIsIt: Int
    
    init() {
        players = []
        whoseTurnIsIt = -1
    }
    
    mutating func play() {
        print("-------- Welcome to ZombieDice --------")
        var playerReader = PlayerReader()
        players = playerReader.getPlayers()
        
        var wantToPlayAgain = false
        repeat {
            startGame()
            print("Do you want to play again? (yes/no)")
            if let playAgain = readLine(), playAgain == "yes" {
                wantToPlayAgain = true
            }
        } while (wantToPlayAgain)
    }
    
    mutating func startGame() {
        whoseTurnIsIt = Int.random(in: 0..<players.count)
        var endGame = false
        
        while (!endGame) {
            printStatictics()
            var playersTurn = PlayerTurn()
            let hasWon = playersTurn.play(player: players[whoseTurnIsIt])
            
            if (hasWon) {
                endGame = true
            } else {
                whoseTurnIsIt = (whoseTurnIsIt + 1) % players.count
            }
        }
    }
    
    func printStatictics() {
        print("--------- Statistics: --------")
        print("==============================")
        for player in players {
            print("\(player.name) ate \(player.score) brains.")
        }
        print("==============================")
        print("\(players[whoseTurnIsIt].name) is rolling now!")
        print("==============================")
    }
}

