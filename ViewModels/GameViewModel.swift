import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var currentNumber: Int = 0
    @Published var timeRemaining: Int = 5
    @Published var isGameActive = true

    private let primeManager = PrimeManager()
    @Published var gameState = GameState()

    private var timer: Timer?

    init() {
        nextNumber()
    }

    func submitAnswer(isPrime: Bool) -> Bool {
        let isCorrect = primeManager.isPrime(currentNumber) == isPrime
        gameState.answerSelected(isCorrect: isCorrect)

        if gameState.totalAnswers >= 10 {
            endGame()
        } else {
            nextNumber()
        }

        return isCorrect
    }

    func nextNumber() {
        currentNumber = primeManager.getNextNumber()
        resetTimer()
    }

    func resetGame() {
        gameState.resetGame()
        primeManager.resetHistory()
        isGameActive = true
        nextNumber()
    }

    private func resetTimer() {
        timer?.invalidate()
        timeRemaining = 5

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                _ = self.submitAnswer(isPrime: false)  // Auto-fail the question
            }
        }
    }

    private func endGame() {
        isGameActive = false
        timer?.invalidate()
    }
}
