// --- Day 3: Rucksack Reorganization ---
// https://adventofcode.com/2022/day/3
import Foundation

func readInput(from path: String) throws -> String {
    let url = URL(fileURLWithPath: path)
    return try String(contentsOf: url, encoding: .utf8)
}
let rucksacks = try readInput(from: "input/day-03.txt")

// MARK: - Part One
print("--- Day 3: Rucksack Reorganization ---")

private func totalPriority(from rucksacks: String) -> Int {
    var priority = 0
    rucksacks.enumerateLines { line, _ in
        let separator = line.index(
            line.startIndex, offsetBy: line.indices.count / 2, limitedBy: line.endIndex
        )!
        Set(line[line.startIndex..<separator])
            .intersection(Set(line[separator..<line.endIndex]))
            .forEach { priority += Int($0.asciiValue ?? 0) - ($0.isLowercase ? 96 : 38) }
    }
    return priority
}

print("Solution:", totalPriority(from: rucksacks))
// Solution: 7701

// MARK: - Part Two
print("--- Part Two ---")

private func totalPriorityGrouped(from rucksacks: String) -> Int {
    var priority = 0
    var group = [Set<Character>]()
    rucksacks.enumerateLines { line, _ in
        group.append(Set(line))
        guard group.count == 3 else { return }
        group[0].intersection(group[1]).intersection(group[2]).forEach {
            priority += Int($0.asciiValue ?? 0) - ($0.isLowercase ? 96 : 38)
        }
        group = []
    }
    return priority
}

print("Solution:", totalPriorityGrouped(from: rucksacks))
// Solution: 2644
