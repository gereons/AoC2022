//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/11
//

import AoCTools

private enum Operation {
    case add(Int)
    case multiply(Int)
    case square
}

private class Monkey {
    let id: Int
    let items: [Int]
    let operation: Operation
    let testDivisible: Int
    let throwTrue: Int
    let throwFalse: Int

    init(_ lines: [String]) {
        assert(lines.count == 6)
        
        var parts = lines[0].trimmed().components(separatedBy: " ")
        id = Int(String(parts[1].dropLast()))!
        parts = lines[1].trimmed().components(separatedBy: ":")
        items = parts[1].trimmed().components(separatedBy: ", ").map { Int($0)! }

        parts = lines[2].trimmed().components(separatedBy: " ")
        switch parts[4] {
        case "+":
            operation = .add(Int(parts[5])!)
        case "*":
            if let mul = Int(parts[5]) {
                operation = .multiply(mul)
            } else {
                assert(parts[5] == "old")
                operation = .square
            }
        default: fatalError()
        }

        parts = lines[3].trimmed().components(separatedBy: " ")
        testDivisible = Int(parts[3])!

        parts = lines[4].trimmed().components(separatedBy: " ")
        throwTrue = Int(parts[5])!

        parts = lines[5].trimmed().components(separatedBy: " ")
        throwFalse = Int(parts[5])!
    }
}


final class Day11: AOCDay {
    private let monkeys: [Monkey]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput

        monkeys = input.lines.split(whereSeparator: \.isEmpty).map { Monkey(Array($0)) }
    }

    func part1() -> Int {
        monkeyBusiness(rounds: 20, reduceWorry: true)
    }

    func part2() -> Int {
        monkeyBusiness(rounds: 10000, reduceWorry: false)
    }

    private func monkeyBusiness(rounds: Int, reduceWorry: Bool) -> Int {
        var inspectCounts = [Int: Int]()

        var items = Dictionary(uniqueKeysWithValues: monkeys.map { ($0.id, $0.items) })
        let modulus = monkeys.map { $0.testDivisible }.reduce(1, *)

        for _ in 0 ..< rounds {
            for monkey in monkeys {
                inspectCounts[monkey.id, default: 0] += items[monkey.id]!.count
                for item in items[monkey.id]! {
                    var worry = item
                    switch monkey.operation {
                    case .add(let add): worry += add
                    case .multiply(let mul): worry *= mul
                    case .square: worry *= worry
                    }
                    worry %= modulus
                    if reduceWorry {
                        worry /= 3
                    }
                    if worry.isMultiple(of: monkey.testDivisible) {
                        items[monkey.throwTrue]!.append(worry)
                    } else {
                        items[monkey.throwFalse]!.append(worry)
                    }
                }
                items[monkey.id] = []
            }
        }

        return inspectCounts.values.sorted(by: >).prefix(2).reduce(1, *)
    }
}
