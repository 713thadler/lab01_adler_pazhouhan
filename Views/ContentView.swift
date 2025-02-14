import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    @State private var showResultDialog = false
    @State private var lastAnswerCorrect: Bool? = nil  // Stores if the last answer was correct

    var body: some View {
        VStack(spacing: 20) {
            Text("\(viewModel.currentNumber)")
                .font(.system(size: 60, weight: .bold))

            Text("Time remaining: \(viewModel.timeRemaining)")
                .font(.headline)
                .foregroundColor(viewModel.timeRemaining > 2 ? .black : .red) // Warn in red if time is running out

            if let correct = lastAnswerCorrect {
                Image(systemName: correct ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(correct ? .green : .red)
                    .font(.system(size: 50))
                    .transition(.opacity)
            }

            HStack(spacing: 20) {
                Button("Prime") {
                    handleAnswer(isPrime: true)
                }
                .buttonStyle(.borderedProminent)

                Button("Not Prime") {
                    handleAnswer(isPrime: false)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .alert("Game Over", isPresented: $showResultDialog) {
            Button("OK", role: .cancel) {
                viewModel.resetGame()
            }
        } message: {
            Text(viewModel.gameState.getGameSummary())
        }
        .onReceive(viewModel.$isGameActive) { isActive in
            if !isActive {
                showResultDialog = true
            }
        }
        .onAppear {
            viewModel.resetGame()
        }
    }

    func handleAnswer(isPrime: Bool) {
        lastAnswerCorrect = viewModel.submitAnswer(isPrime: isPrime)

        // Remove visual feedback after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            lastAnswerCorrect = nil
        }
    }
}
