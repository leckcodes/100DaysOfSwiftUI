//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Gregory Leck on 2019-10-18.
//  Copyright © 2019 Gregory Leck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var shapes = ["ROCK", "PAPER", "SCISSORS"]
    
    @State private var chosenShape = Int.random(in: 0...2)
    
    @State private var playerWins = Bool.random()
    
    @State private var showingScore = false
    
    @State private var score = 0
    
    @State private var numberOfTurns = 0
    
    var body: some View {
        
        VStack() {
            
            HStack {
                Text("Rock, Paper, Scissors")
                Image(systemName: "globe")
                Image(systemName: "paperplane")
                Image(systemName: "scissors")
            }
            .font(.system(.title))
            
            Spacer()
            
            VStack {
                Text("We chose: \(shapes[chosenShape])")
                Text("You must \(playerWins ? "WIN" : "LOSE")")
                Text("Your score is: \(score)")
            }
            .font(.system(.title))
            
            Spacer()
            
            VStack(spacing: 50) {
                
                if chosenShape != 0 {
                    Button(action: {
                        self.playerTapped(choice: "ROCK")
                    }) {
                        Image(systemName: "globe")
                    }
                }
                
                if chosenShape != 1 {
                    Button(action: {
                        self.playerTapped(choice: "PAPER")
                        
                    }) {
                        Image(systemName: "paperplane")
                    }
                }
                
                if chosenShape != 2 {
                    Button(action: {
                        self.playerTapped(choice: "SCISSORS")
                    }) {
                        Image(systemName: "scissors")
                    }
                }
            }
            .font(.system(size: 40))
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("Game Over"), message: Text("Your score is: \(score)"), dismissButton: .default(Text("New Game?")) {
                self.restart()
                })
        }
    }
    
    func playerTapped(choice: String) {
        
        if playerWins == true {
            if chosenShape == 0 && choice == "PAPER" {
                successOrFailure(result: "success")
            } else if chosenShape == 1 && choice == "SCISSORS" {
                successOrFailure(result: "success")
            } else if chosenShape == 2 && choice == "ROCK" {
                successOrFailure(result: "success")
            } else {
                successOrFailure(result: "failure")
            }
        } else if playerWins == false {
            if chosenShape == 0 && choice == "PAPER" {
                successOrFailure(result: "failure")
            } else if chosenShape == 1 && choice == "SCISSORS" {
                successOrFailure(result: "failure")
            } else if chosenShape == 2 && choice == "ROCK" {
                successOrFailure(result: "failure")
            } else {
                successOrFailure(result: "success")
            }
        }
    }
    
    func successOrFailure(result: String) {
        
        if result == "success" {
            self.score += 1
        } else if result == "failure" {
            self.score -= 1
        }
        
        numberOfTurns += 1
        
        if numberOfTurns == 10 {
            showingScore = true
        } else {
            chosenShape = Int.random(in: 0...2)
            playerWins = Bool.random()
        }
    }
    
    func restart() {
        showingScore = false
        score = 0
        numberOfTurns = 0
        chosenShape = Int.random(in: 0...2)
        playerWins = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
