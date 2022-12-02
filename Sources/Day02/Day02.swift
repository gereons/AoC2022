//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/3
//

import AoCTools

private enum Shape {
    case rock, paper, scissors

    init(_ rawValue: String) {
        switch rawValue {
        case "A", "X": self = .rock
        case "B", "Y": self = .paper
        case "C", "Z": self = .scissors
        default: fatalError()
        }
    }

    var score: Int {
        switch self {
        case .rock: return 1
        case .paper: return 2
        case .scissors: return 3
        }
    }
}

final class Day02: AOCDay {
    private typealias Hands = (opponent: Shape, mine: Shape)

    private let rounds: [Hands]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput

        rounds = input.lines.map { line in
            let parts = line.components(separatedBy: " ")
            return (opponent: Shape(parts[0]), mine: Shape(parts[1]))
        }
    }

    func part1() -> Int {
        rounds.reduce(0) {
            $0 + $1.mine.score + fight($1)
        }
    }

    func part2() -> Int {
        rounds.reduce(0) {
            let mine = choose($1)
            return $0 + mine.score + fight((opponent: $1.opponent, mine: mine))
        }
    }

    private func fight(_ hands: Hands) -> Int {
        switch (hands.opponent, hands.mine) {
        case (.rock, .rock): return 3
        case (.paper, .paper): return 3
        case (.scissors, .scissors): return 3

        case (.rock, .scissors): return 0
        case (.scissors, .rock): return 6

        case (.paper, .rock): return 0
        case (.rock, .paper): return 6

        case (.scissors, .paper): return 0
        case (.paper, .scissors): return 6
        }
    }

    // rock = loose
    // paper = draw
    // scissors = win
    private func choose(_ hands: Hands) -> Shape {
        switch (hands.opponent, hands.mine) {
        case (_, .paper): return hands.opponent

        case (.rock, .rock): return .scissors
        case (.scissors, .rock): return .paper
        case (.paper, .rock): return .rock

        case (.scissors, .scissors): return .rock
        case (.rock, .scissors): return .paper
        case (.paper, .scissors): return .scissors
        }
    }
}
