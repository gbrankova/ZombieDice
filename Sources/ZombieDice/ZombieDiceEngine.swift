//
//  File.swift
//  
//
//  Created by Gabriela Brankova on 9.07.20.
//

import Foundation

struct ZombieDiceEngine {
    var players: [Player]
    var whoseTurnIsIt: Int  // Keeps track of the player order
    
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
            resetScoresToPlayers()
            startGame()
            print("Do you want to play Zombie Dice again? (yes/no)")
            if let playAgain = readLine(), playAgain == "yes" {
                wantToPlayAgain = true
            }
        } while (wantToPlayAgain)
    }
    
    /* Statistics about the brain score of the players and who is next
       is printed out before each turn of a player */
    mutating func startGame() {
        // the first player is randomly chosed
        whoseTurnIsIt = Int.random(in: 0..<players.count)
        var endGame = false
        
        while (!endGame) {
            printStatictics()
            var playersTurn = PlayerTurn(player: players[whoseTurnIsIt])
            let hasWon = playersTurn.play()
            
            if (hasWon) {
                endGame = true
            } else {
                whoseTurnIsIt = (whoseTurnIsIt + 1) % players.count
            }
        }
    }
    
    func resetScoresToPlayers() {
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

