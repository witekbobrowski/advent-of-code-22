// --- Day 2: Rock Paper Scissors ---
// https://adventofcode.com/2022/day/1
import Foundation

func readInput(from path: String) throws -> String {
    let url = URL(fileURLWithPath: path)
    return try String(contentsOf: url, encoding: .utf8)
}
let strategyGuide = try readInput(from: "input/day-02.txt")

// MARK: - Part One
print("--- Day 2: Rock Paper Scissors ---")

private func predictedScore(using strategyGuide: String) -> Int {
    var score = 0
    strategyGuide.enumerateLines { line, _ in
        let opponent = ["A": 1, "B": 2, "C": 3][line.first!, default: 0]
        let me = ["X": 1, "Y": 2, "Z": 3][line.last!, default: 0]
        score += me
        score += me == opponent ? 3 : (me == opponent % 3 + 1 ? 6 : 0)
    }
    return score
}

print("Solution:", predictedScore(using: strategyGuide))
// Solution: 8890

// MARK: - Part Two
print("--- Part Two ---")

private func correctlyPredictedScore(using strategyGuide: String) -> Int {
    var score = 0
    strategyGuide.enumerateLines { line, _ in
        let opponent = ["A": 1, "B": 2, "C": 3][line.first!, default: 0]
        let result = ["X": 0, "Y": 3, "Z": 6][line.last!, default: 0]
        score += result
        score += result == 3 ? opponent : (result == 6 ? opponent % 3 + 1 : (opponent + 1) % 3 + 1)
    }
    return score
}

print("Solution:", correctlyPredictedScore(using: strategyGuide))
// Solution: 10238
