import Foundation

class GameState {
    private(set) var correctAnswers = 0
    private(set) var incorrectAnswers = 0

    var totalAnswers: Int {
        return correctAnswers + incorrectAnswers
    }

    func answerSelected(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        } else {
            incorrectAnswers += 1
        }
    }

    func resetGame() {
        correctAnswers = 0
        incorrectAnswers = 0
    }

    func getGameSummary() -> String {
        return "Correct: \(correctAnswers), Incorrect: \(incorrectAnswers), Total: \(totalAnswers)"
    }
}
