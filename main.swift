
import Foundation
import ViewModels

let viewModel = GameViewModel()

func playGame() {
    print("Welcome to the Prime Number Game!")
    print("For each number, type 'y' if it's prime, 'n' if it's not prime.")
    print("You have 5 seconds to answer each question.\n")
    
    viewModel.resetGame()
    
    while viewModel.gameState.totalAnswers < 10 && viewModel.isGameActive {
        print("\nNumber: \(viewModel.currentNumber)")
        print("Is this number prime? (y/n): ")
        
        let startTime = Date()
        guard let input = readLine()?.lowercased() else { continue }
        let timeElapsed = Date().timeIntervalSince(startTime)
        
        if timeElapsed > 5 {
            print("Time's up! Too slow!")
            viewModel.submitAnswer(isPrime: false)
        } else {
            let isPrime = input == "y"
            viewModel.submitAnswer(isPrime: isPrime)
        }
        
        print("Score: \(viewModel.gameState.correctAnswers) correct, \(viewModel.gameState.incorrectAnswers) incorrect")
    }
    
    print("\nGame Over!")
    print("Final Score: \(viewModel.gameState.correctAnswers) out of \(viewModel.gameState.totalAnswers)")
}

playGame()
