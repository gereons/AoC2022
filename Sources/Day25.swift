//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/25
//

import AoCTools
import Foundation

final class Day25: AdventOfCodeDay {
    let title = "Full of Hot Air"
    
    let snafus: [String]

    let toDigit: [Character: Int] = [ "2": 2, "1": 1, "0": 0, "-": -1, "=": -2 ]
    let fromDigit: [Int: String] =  [ 2: "2", 1: "1", 0: "0", -1: "-", -2: "=" ]

    init(input: String) {
        snafus = input.lines
    }

    func part1() -> String {
        let sum = snafus.reduce(0) { $0 + toInt($1) }
        return toSnafu(sum)
    }

    private func toInt(_ s: String) -> Int {
        s.reduce(0) {
            $0 * 5 + toDigit[$1]!
        }
    }

    private func toSnafu(_ i: Int) -> String {
        if i == 0 {
            return ""
        }
        let mod5 = i % 5
        switch mod5 {
        case 0, 1, 2: return toSnafu(i / 5) + fromDigit[mod5]!
        case 3, 4: return toSnafu(i / 5 + 1) + fromDigit[mod5 - 5]!
        default: fatalError()
        }
    }

    func part2() {}
}
