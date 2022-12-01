//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/1
//

import AoCTools

final class Day01: AOCDay {
    let elves: [[Int]]
    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput

        var elves = [[Int]]()
        var current = [Int]()
        for line in input.lines {
            if line.isEmpty {
                elves.append(current)
                current = []
            } else {
                current.append(Int(line)!)
            }
        }

        if !current.isEmpty {
            elves.append(current)
        }
        self.elves = elves
    }

    func part1() -> Int {
        var maxCal = 0
        for elf in elves {
            let calories = elf.reduce(0, +)
            maxCal = max(calories, maxCal)
        }
        return maxCal
    }

    func part2() -> Int {
        var totals = [Int]()
        for elf in elves {
            let calories = elf.reduce(0, +)
            totals.append(calories)
        }
        totals.sort(by: >)
        return totals.prefix(3).reduce(0, +)
    }
}
