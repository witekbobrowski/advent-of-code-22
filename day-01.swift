// --- Day 1: Calorie Counting ---
// https://adventofcode.com/2022/day/1
import Foundation

func readInput(from path: String) throws -> String {
    let url = URL(fileURLWithPath: path)
    return try String(contentsOf: url, encoding: .utf8)
}
let input = try readInput(from: "input/day-01.txt")

// MARK: - Part One
print("--- Day 1: Calorie Counting ---")

private func mostCarriedCalories(from input: String) -> Int {
    var highscore = 0
    var score = 0
    input.enumerateLines { line, _ in
        if line != "", let current = Int(line) { return score += current }
        highscore = max(score, highscore)
        score = 0
    }
    return highscore
}

print("Solution:", mostCarriedCalories(from: input))
// Solution: 66306

// MARK: - Part Two
print("--- Part Two ---")

private func threeMostCarriedCalories(from input: String) -> Int {
    var highscores = [Int]()
    var score = 0
    input.enumerateLines { line, _ in
        if line != "", let current = Int(line) { return score += current }
        if highscores.count < 3 {
            highscores.append(score)
        } else if highscores.last ?? 0 < score {
            highscores.removeLast()
            highscores.append(score)
            highscores.sort(by: >)
        }
        score = 0
    }
    return highscores.reduce(0, +)
}

print("Solution:", threeMostCarriedCalories(from: input))
// Solution: 195292
