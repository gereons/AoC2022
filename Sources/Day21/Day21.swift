//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/21
//

import Foundation
import AoCTools

private enum Yell {
    case constant(Decimal)
    case op(String, String, String)
}

private struct Monkey {
    let name: String
    let yell: Yell

    // root: pppw + sjmn
    // dbpl: 5
    init(_ str: String) {
        let parts = str.components(separatedBy: " ")
        name = String(parts[0].dropLast())
        if let int = Int(parts[1]) {
            yell = .constant(Decimal(int))
        } else {
            yell = .op(parts[1], parts[2], parts[3])
        }
    }

    func uses(_ variable: String) -> String? {
        switch yell {
        case .op(let v1, _, let v2):
            if v1 == variable || v2 == variable { return self.name }
            return nil
        case .constant: return nil
        }
    }
}

final class Day21: AOCDay {
    private let monkeys: [String: Monkey]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput
        monkeys = input.lines.map { Monkey($0) }.mapped(by: \.name)
    }

    func part1() -> Decimal {
        let root = monkeys["root"]!

        return yell(of: root)
    }

    func part2() -> Decimal {
        let root = monkeys["root"]!
        guard case Yell.op(let var1, _, let var2) = root.yell else {
            fatalError()
        }

        var map = [String: String]()
        var check = "humn"
        while check != "root" {
            let prod = monkeys.values.compactMap { $0.uses(check) }
            map[prod[0]] = check
            check = prod[0]
        }

        let testMonkey = monkeys[map["root"]!]!
        let searchMonkey = monkeys[var1 == testMonkey.name ? var2 : var1]!
        let search = yell(of: searchMonkey, 0)

        var lowerBound = 0
        var upperBound = 1_000_000_000_000_000
        var humn: Decimal?
        while lowerBound < upperBound {
            let index = lowerBound + (upperBound - lowerBound) / 2
            let result = yell(of: testMonkey, Decimal(index))
            if result == search {
                humn = Decimal(index)
                break
            } else if result < search {
                upperBound = index - 1
            } else {
                lowerBound = index + 1
            }
        }

        guard let humn else {
            return 0
        }

        return humn
    }

    private func yell(of monkey: Monkey, _ humn: Decimal? = nil) -> Decimal {
        switch monkey.yell {
        case .constant(let int):
            if let humn, monkey.name == "humn" {
                return humn
            }
            return int
        case .op(let var1, let op, let var2):
            let v1 = yell(of: monkeys[var1]!, humn)
            let v2 = yell(of: monkeys[var2]!, humn)
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
