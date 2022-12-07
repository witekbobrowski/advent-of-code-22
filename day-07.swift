// --- Day 7: No Space Left On Device ---
// https://adventofcode.com/2022/day/7
import Foundation

private func readInput(from path: String) throws -> String {
    let url = URL(fileURLWithPath: path)
    return try String(contentsOf: url, encoding: .utf8)
}
private let terminalOutput = try readInput(from: "input/day-07.txt")

private func traverseFilesystem(_ terminalOutput: String) -> [String: Int] {
    var current = [String]()
    var sizes = [String: Int]()
    terminalOutput.enumerateLines { line, _ in
        if line.first == "$" {
            let command = line.components(separatedBy: " ").dropFirst()
            guard command.first == "cd" else { return }
            guard command.last == ".." else {
                return current.append(command.last ?? "")
            }
            current.removeLast()
        } else if let size = Int(line.prefix { $0 != " " }) {
            _ = current.reduce([String]()) { path, current in
                sizes[(path + [current]).joined(separator: "-"), default: 0] += size
                return path + [current]
            }
        }
    }
    return sizes
}

// MARK: - Part One
print("--- Day 7: No Space Left On Device ---")

private func disposableSpace(_ terminalOutput: String) -> Int {
    traverseFilesystem(terminalOutput)
        .filter { $1 <= 100000 }.values
        .reduce(0, +)
}

print("Solution:", disposableSpace(terminalOutput))
// Solution: 1581595

// MARK: - Part Two
print("--- Part Two ---")

private func disposableSpaceWithRequirements(_ terminalOutput: String) -> Int {
    let sizes = traverseFilesystem(terminalOutput)
    return sizes
        .filter { (40000000 - sizes["/"]!) + $1 > 0 }
        .min { $0.1 < $1.1 }?.1 ?? 0
}

print("Solution:", disposableSpaceWithRequirements(terminalOutput))
// Solution: 1544176
