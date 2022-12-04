// --- Day 4: Camp Cleanup ---
// https://adventofcode.com/2022/day/4
import Foundation

func readInput(from path: String) throws -> String {
    let url = URL(fileURLWithPath: path)
    return try String(contentsOf: url, encoding: .utf8)
}
let assignments = try readInput(from: "input/day-04.txt")

// MARK: - Part One
print("--- Day 4: Camp Cleanup ---")

private func overlap(in assignments: String) -> Int {
    var count = 0
    assignments.enumerateLines { line, _ in
        let pairs = line.components(separatedBy: ",")
            .map { $0.components(separatedBy: "-").map { Int($0)! } }
        if pairs[0][0] <= pairs[1][0], pairs[0][1] >= pairs[1][1] {
            count += 1
        } else if pairs[0][0] >= pairs[1][0], pairs[0][1] <= pairs[1][1] {
            count += 1
        }
    }
    return count
}

print("Solution:", overlap(in: assignments))
// Solution: 471

// MARK: - Part Two
print("--- Part Two ---")

private func anyOverlap(in assignments: String) -> Int {
    var count = 0
    assignments.enumerateLines { line, _ in
        let pairs = line.components(separatedBy: ",")
            .map { $0.components(separatedBy: "-") }.map { Int($0[0])!...Int($0[1])! }
        if pairs[0].overlaps(pairs[1]) { count += 1 }
    }
    return count
}

print("Solution:", anyOverlap(in: assignments))
// Solution: 888
