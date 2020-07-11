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
        print("-------- Welcome to Zombie Dice --------")
        var playerReader = PlayerReader()
        players = playerReader.getPlayers()
        
        var wantToPlayAgain: Bool
        repeat {
            wantToPlayAgain = false
            resetScores()
            startGame()
            print("Do you want to play Zombie Dice again? (yes/no)")
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
    
    func resetScores() {
        for player in players {
            player.resetScore()
        }
    }
    
    func printStatictics() {
        print("\n\n\n")
        print("--------- Statistics: --------")
        print("==============================")
        for player in players {
            print("\(player.name) ate \(player.score) brains.")
        }
        print("==============================")
        print("\(players[whoseTurnIsIt].name) is rolling now!")
        print("==============================")
        print("\n\n\n")
    }
}

