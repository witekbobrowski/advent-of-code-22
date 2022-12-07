// --- Day 6: Tuning Trouble ---
// https://adventofcode.com/2022/day/6
import Foundation

func readInput(from path: String) throws -> String {
    let url = URL(fileURLWithPath: path)
    return try String(contentsOf: url, encoding: .utf8)
}
let datastream = try readInput(from: "input/day-06.txt")

// MARK: - Part One
print("--- Day 6: Tuning Trouble ---")

private func marker(in datastream: String, lenght: Int = 4) -> Int {
    datastream.indices.enumerated().first { offset, index in
        let candidate = datastream.index(index, offsetBy: lenght - 1, limitedBy: datastream.endIndex)!
        return Set(datastream[index...candidate]).count == lenght
    }!.0 + lenght
}

print("Solution:", marker(in: datastream))
// Solution: 1093

// MARK: - Part Two
print("--- Part Two ---")

print("Solution:", marker(in: datastream, lenght: 14))
// Solution: 3534
