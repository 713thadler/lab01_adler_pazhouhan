import Foundation

class PrimeManager {
    private var usedNumbers: Set<Int> = []
    private let primes: Set<Int> = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
    private let numberRange = 1...50

    func getNextNumber() -> Int {
        let unusedNumbers = (numberRange).filter { !usedNumbers.contains($0) }

        if let newNumber = unusedNumbers.randomElement() {
            usedNumbers.insert(newNumber)
            return newNumber
        } else {
            resetHistory()
            return getNextNumber()
        }
    }

    func resetHistory() {
        usedNumbers.removeAll()
    }

    func isPrime(_ number: Int) -> Bool {
        return primes.contains(number)
    }
}
