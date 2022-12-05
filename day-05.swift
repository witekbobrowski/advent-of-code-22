// --- Day 5: Supply Stacks ---
// https://adventofcode.com/2022/day/5
import Foundation

private func readInput(from path: String) throws -> String {
    let url = URL(fileURLWithPath: path)
    return try String(contentsOf: url, encoding: .utf8)
}
private let procedure = try readInput(from: "input/day-05.txt")

// MARK: - Part One
print("--- Day 5: Supply Stacks ---")

private func buildCrates(from input: [String]) -> [[Character]] {
    var crates = [[Character]]()
    input.last?.components(separatedBy: " ").compactMap(Int.init).forEach { _ in crates.append([]) }
    input.dropLast().reversed().forEach { line in
        crates.indices.forEach { crateIndex in
            line.index(line.startIndex, offsetBy: 1 + crateIndex * 4, limitedBy: line.endIndex).map { index in
                if line[index] != " " { crates[crateIndex].append(line[index]) }
            }
        }
    }
    return crates
}

private func perform(move: String, _ crates: inout [[Character]]) {
    let moves = move.components(separatedBy: " ").compactMap { Int($0) }
    (0..<moves[0]).forEach { _ in
        crates[moves[2] - 1].append(crates[moves[1] - 1].removeLast())
    }
}

private func rearrangement(using procedure: String) -> String {
    var cache = [String]()
    var crates = [[Character]]()
    procedure.enumerateLines { line, _ in
        if !crates.isEmpty {
            perform(move: line, &crates)
        } else if line.isEmpty {
            crates = buildCrates(from: cache)
        } else {
            cache.append(line)
        }
    }
    return crates.compactMap(\.last).map(String.init).joined(separator: "")
}

print("Solution:", rearrangement(using: procedure))
// Solution: VCTFTJQCG

// MARK: - Part Two
print("--- Part Two ---")

private func perform9001(move: String, _ crates: inout [[Character]]) {
    let moves = move.components(separatedBy: " ").compactMap { Int($0) }
    (0..<moves[0])
        .map { _ in crates[moves[1] - 1].removeLast() }.reversed()
        .forEach { crates[moves[2] - 1].append($0) }
}

private func rearrangement9001(using procedure: String) -> String {
    var cache = [String]()
    var crates = [[Character]]()
    procedure.enumerateLines { line, _ in
        if !crates.isEmpty {
            perform9001(move: line, &crates)
        } else if line.isEmpty {
            crates = buildCrates(from: cache)
        } else {
            cache.append(line)
        }
    }
    return crates.compactMap(\.last).map(String.init).joined(separator: "")
}

print("Solution:", rearrangement9001(using: procedure))
// Solution: 888
