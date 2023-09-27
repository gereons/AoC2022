//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/4
//

import AoCTools
import RegexBuilder

final class Day04: AOCDay {
    let assignments: [(Set<Int>, Set<Int>)]

    init(input: String? = nil) {
        let input = input ?? Self.input

        let r1start = Reference(Int.self)
        let r1end = Reference(Int.self)
        let r2start = Reference(Int.self)
        let r2end = Reference(Int.self)
        let regex = Regex {
            Capture(as: r1start) { ZeroOrMore(.digit) } transform: { Int($0)! }
            "-"
            Capture(as: r1end) { ZeroOrMore(.digit) } transform: { Int($0)! }
            ","
            Capture(as: r2start) { ZeroOrMore(.digit) } transform: { Int($0)! }
            "-"
            Capture(as: r2end) { ZeroOrMore(.digit) } transform: { Int($0)! }
        }

        assignments = input.lines.map {
            let matches = try! regex.wholeMatch(in: $0)!

            let range1 = matches[r1start] ... matches[r1end]
            let range2 = matches[r2start] ... matches[r2end]
            return (Set(range1), Set(range2))
        }
    }

    func part1() -> Int {
        assignments.count { (set1, set2) in
            set2.isSubset(of: set1) || set1.isSubset(of: set2)
        }
    }

    func part2() -> Int {
        assignments.count { (set1, set2) in
            !(set1.intersection(set2).isEmpty || set2.intersection(set1).isEmpty)
        }
    }
}
