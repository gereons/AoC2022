//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/1
//

import AoCTools

final class Day01: AOCDay {
    let calories: [[Int]]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput

        let sections = input.components(separatedBy: "\n\n")
        self.calories = sections.map {
            $0.lines.map { Int($0)! }
        }
    }

    func part1() -> Int {
        calories
            .map { $0.reduce(0, +) }
            .max()!
    }

    func part2() -> Int {
        calories
            .map { $0.reduce(0, +) }
            .sorted(by: >)
            .prefix(3)
            .reduce(0, +)
    }
}
