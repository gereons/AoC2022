//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/21
//

import AoCTools

private enum Yell {
    case int(Int)
    case op(String, String, String)
}

private struct Monkey {
    let variable: String
    let value: Yell

    // root: pppw + sjmn
    // dbpl: 5
    init(_ str: String) {
        let parts = str.components(separatedBy: " ")
        variable = String(parts[0].dropLast())
        if let int = Int(parts[1]) {
            value = .int(int)
        } else {
            value = .op(parts[1], parts[2], parts[3])
        }
    }
}

final class Day21: AOCDay {
    private let monkeys: [String: Monkey]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput
        monkeys = input.lines.map { Monkey($0) }.mapped(by: \.variable)
    }

    func part1() -> Int {
        let root = monkeys["root"]!

        return evaluate(root)
    }

    func part2() -> Int {
        return 0
    }

    private func evaluate(_ monkey: Monkey) -> Int {
        switch monkey.value {
        case .int(let int):
            return int
        case .op(let var1, let op, let var2):
            let v1 = evaluate(monkeys[var1]!)
            let v2 = evaluate(monkeys[var2]!)
            switch op {
            case "+": return v1 + v2
            case "-": return v1 - v2
            case "*": return v1 * v2
            case "/": return v1 / v2
            default: fatalError()
            }
        }
    }
}
