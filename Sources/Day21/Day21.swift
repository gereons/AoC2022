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

    func uses(_ variable: String) -> String? {
        switch value {
        case .op(let v1, _, let v2):
            if v1 == variable || v2 == variable { return self.variable }
            return nil
        case .int: return nil
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

        return yells(root)
    }

    func part2() -> Int {
        let root = monkeys["root"]!
        guard case Yell.op(let var1, _, let var2) = root.value else {
            fatalError()
        }

        var map = [String: String]()
        var check = "humn"
        while check != "root" {
            let prod = monkeys.values.compactMap { $0.uses(check) }
            assert(prod.count == 1)
            map[prod[0]] = check
            check = prod[0]
        }

        let testMonkey = monkeys[map["root"]!]!
        let searchMonkey = monkeys[var1 == testMonkey.variable ? var2 : var1]!
        let search = yells(searchMonkey, 0)

        var lowerBound = 0
        var upperBound = 1_000_000_000_000_000
        var humn: Int?
        while lowerBound < upperBound {
            let index = lowerBound + (upperBound - lowerBound) / 2
            let result = yells(testMonkey, index)
            if result == search {
                humn = index
                break
            } else if result < search {
                upperBound = index - 1
            } else {
                lowerBound = index + 1
            }
        }

        guard var humn else { fatalError() }

        while yells(monkeys[var1]!, humn - 1) == search {
            humn -= 1
        }
        return humn
    }

    private func yells(_ monkey: Monkey, _ humn: Int? = nil) -> Int {
        switch monkey.value {
        case .int(let int):
            if let humn, monkey.variable == "humn" {
                return humn
            }
            return int
        case .op(let var1, let op, let var2):
            let v1 = yells(monkeys[var1]!, humn)
            let v2 = yells(monkeys[var2]!, humn)
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
