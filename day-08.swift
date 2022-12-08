// --- Day 8: Treetop Tree House ---
// https://adventofcode.com/2022/day/7
import Foundation

private func readInput(from path: String) throws -> String {
    let url = URL(fileURLWithPath: path)
    return try String(contentsOf: url, encoding: .utf8)
}
private let map = try readInput(from: "input/day-08.txt")

private func convert(_ map: String) -> [[Int]] {
    var converted = [[Int]]()
    map.enumerateLines { line, _ in
        converted.append(line.map { Int(String($0))! })
    }
    return converted
}

// MARK: - Part One
print("--- Day 8: Treetop Tree House ---")

private func visibleTrees(_ map: String) -> Int {
    let map = convert(map)
    var visibility = Array(
        repeating: Array(repeating: false, count: map.count), count: map.count
    )

    // South-East sweep
    var north = map.first! // Highest trees visible from the north
    map.indices.forEach { row in
        var west = map[row].first! // Highest tree visible from the west
        map[row].indices.forEach { col in
            if row == 0 || col == 0 { return visibility[row][col] = true }
            visibility[row][col] = map[row][col] > north[col] || map[row][col] > west
            north[col] = max(map[row][col], north[col])
            west = max(map[row][col], west)
        }
    }

    // North-West sweep and countdown
    var south = map.last! // Highest trees visible from the south
    return map.indices.reversed().reduce(0) { count, row in
        var east = map[row].last! // Highest tree visible from the east
        return map[row].indices.reversed().reduce(count) { count, col in
            if row == map.count - 1 || col == map.count - 1 { return count + 1 }
            let isVisible = visibility[row][col] || map[row][col] > south[col] || map[row][col] > east
            south[col] = max(map[row][col], south[col])
            east = max(map[row][col], east)
            return isVisible ? count + 1 : count
        }
    }
}

print("Solution:", visibleTrees(map))
// Solution: 1787

// MARK: - Part Two
print("--- Part Two ---")

private func topScoringTree(_ map: String) -> Int {
    let map = convert(map)

    return map.indices.reduce(0) { score, row in
        map[row].indices.reduce(score) { score, col in
            if row == 0 || col == 0 || row == map.count - 1 || col == map.count - 1 { return score }

            var east = map[row][(col + 1)..<map.count].prefix { $0 < map[row][col] }.count
            east += east == (map.count - 1) - col ? 0 : 1
            var south = map[(row + 1)..<map.count].map { $0[col] }.prefix { $0 < map[row][col] }.count
            south += south == (map.count - 1) - row ? 0 : 1
            var west = map[row][0..<col].reversed().prefix { $0 < map[row][col] }.count
            west += west == col ? 0 : 1
            var north = map[0..<row].map { $0[col] }.reversed().prefix { $0 < map[row][col] }.count
            north += north == row ? 0 : 1

            return max(score, east * south * west * north)
        }
    }
}

print("Solution:", topScoringTree(map))
// Solution: 440640
