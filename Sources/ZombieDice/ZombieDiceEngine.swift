//
//  File.swift
//  
//
//  Created by Gabriela Brankova on 9.07.20.
//

import Foundation

struct ZombieDiceEngine {
    var players: [Player]
    //var assistant: GameAssistant
    var diePool: DiePool
    var currentScore: CurrentScore
    
    init() {
        diePool = DiePool()
        players = []
        currentScore = CurrentScore()
        //assistant = GamesAssistant()
    }
    
    mutating func startGame() {
        print("-------- Welcome to ZombieDice --------")
        var playerReader = PlayerReader()
        players = playerReader.getPlayers()
        getStatictics()
        
        var whoseTurnIsIt = Int.random(in: 0..<players.count)
        var endOfGame = false
        var diceWithSteps: [Die] = []
        
        while (!endOfGame) {
            diceWithSteps = rollDice(diceWithSteps)
            
            if (currentScore.amIShotguned()) {
                print("💥💥💥 YOU ARE SHOTGUNNED! 💥💥💥")
                resetTurnForNextPlayer()
                diceWithSteps = []
                whoseTurnIsIt = (whoseTurnIsIt + 1) % players.count
            } else {
                var gotAnAnswerFromPlayer = false
                while (!gotAnAnswerFromPlayer) {
                    print("Do you want to roll again? (yes/no)")
                    
                    if let answer = readLine() {
                        if answer == "no" && currentScore.brainsScore != 0 {
                            addNewScoreTo(player: whoseTurnIsIt)
                            if (players[whoseTurnIsIt].score >= 13) {
                                print("\(players[whoseTurnIsIt].name) is the winner! 🏅")
                                endOfGame = true
                            }
                            resetTurnForNextPlayer()
                            diceWithSteps = []
                            whoseTurnIsIt = (whoseTurnIsIt + 1) % players.count
                        }
                        
                        gotAnAnswerFromPlayer = true
                        
                        if (answer != "no" && answer != "yes") {
                            gotAnAnswerFromPlayer = false
                        }
                    }
                }
            }
        }
    }
    
    func rollDice(steps: [Die]) -> [Die] {
        let currentDice = diePool.drawDice(howMany: 3 - steps.count) + steps
        let currentDiceSides = currentDice.map { $0.rollDie() }
        currentScore.updateScores(with: currentDiceSides)
        return getStepDice(dice: currentDice, diceSides: currentDiceSides)
    }
    
    private func getStepDice(dice: [Die], diceSides: [DieSide]) {
        var stepsDice: [Die] = []
        for index in 0..<dice.count {
            if (diceSides[index] == DieSide.Steps){
                stepsDice.append(dice[index])
            }
        }
        return stepsDice
    }
    
    func resetTurnForNextPlayer() {
        diePool.putBackDiceInDiceCup()
        currentScore.reset()
    }
    
    func addNewScoreTo(player index: Int) {
        players[index].score += currentScore.brainsScore
    }
    
    
    func getStatictics() {
        print("--------- Statistics: --------")
        for player in players {
            print("\(player.name) ate \(player.score) brains.")
        }
    }
}

