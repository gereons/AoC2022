//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/2
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

    var draw: Shape {
        return self
    }

    var win: Shape {
        switch self {
        case .rock: return .scissors
        case .paper: return .rock
        case .scissors: return .paper
        }
    }

    var lose: Shape {
        switch self {
        case .rock: return .paper
        case .paper: return .scissors
        case .scissors: return .rock
        }
    }
}

final class Day02: AOCDay {
    private typealias Hands = (opponent: Shape, mine: Shape)

    private let rounds: [Hands]

    init(input: String? = nil) {
        let input = input ?? Self.input

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
        if hands.opponent.draw == hands.mine {
            return 3
        }

        if hands.opponent.lose == hands.mine {
            return 6
        }

        assert(hands.opponent.win == hands.mine)
        return 0
    }

    // rock = lose
    // paper = draw
    // scissors = win
    private func choose(_ hands: Hands) -> Shape {
        switch hands.mine {
        case .paper: return hands.opponent.draw
        case .rock: return hands.opponent.win
        case .scissors: return hands.opponent.lose
        }
    }
}
