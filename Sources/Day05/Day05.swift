//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/5
//

import AoCTools

private struct Move {
    let count: Int
    let from: Int
    let to: Int

    init(_ str: String) {
        // move 1 from 1 to 2
        let parts = str.components(separatedBy: " ")
        count = Int(parts[1])!
        from = Int(parts[3])!
        to = Int(parts[5])!
    }
}

final class Day05: AOCDay {
    private let crates: [Int: [Character]]
    private let moves: [Move]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput

        let parts = input.lines.split(whereSeparator: \.isEmpty)

        var crates = [Int: [Character]]()
        for line in parts[0] {
            // 01234567890
            // [Z] [M] [P]
            for (index, ch) in line.enumerated() {
                if ch.isNumber || ch == " " {
                    continue
                }
                if (index - 1).isMultiple(of: 4) {
                    let crate = 1 + (index - 1) / 4
                    crates[crate, default: []].append(ch)
                }
            }
        }

        self.crates = crates.mapValues {
            $0.reversed()
        }

        moves = parts[1].map { Move($0) }
    }

    func part1() -> String {
        moveCrates(oneByOne: true)
    }

    func part2() -> String {
        moveCrates(oneByOne: false)
    }

    private func moveCrates(oneByOne: Bool) -> String {
        var crates = crates

        for move in moves {
            let moveFrom = crates[move.from]!
            crates[move.from] = moveFrom.dropLast(move.count)
            var moving = Array(moveFrom.suffix(move.count))
            if oneByOne {
                moving = Array(moving.reversed())
            }
            crates[move.to, default: []].append(contentsOf: moving)
        }

        return crates
            .sorted { $0.key < $1.key }
            .compactMap { $0.value.last }
            .map { String($0) }
            .joined()
    }
}
