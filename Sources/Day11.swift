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

    func perform(input: Int) -> Int {
        switch self {
        case .add(let add): return input + add
        case .multiply(let mul): return input * mul
        case .square: return input * input
        }
    }
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


final class Day11: AdventOfCodeDay {
    let title = "Monkey in the Middle"
    
    private let monkeys: [Monkey]

    init(input: String) {
        monkeys = input.lines.split(whereSeparator: \.isEmpty).map { Monkey(Array($0)) }
    }

    func part1() -> Int {
        monkeyBusiness(rounds: 20, reduceWorry: true)
    }

    func part2() -> Int {
        monkeyBusiness(rounds: 10000, reduceWorry: false)
    }

    private func monkeyBusiness(rounds: Int, reduceWorry: Bool) -> Int {
        var inspectCounts = [Int](repeating: 0, count: monkeys.count)

        var items = monkeys.map { $0.items }
        let modulus = monkeys.map { $0.testDivisible }.reduce(1, *)

        for _ in 0 ..< rounds {
            for monkey in monkeys {
                inspectCounts[monkey.id] += items[monkey.id].count
                for item in items[monkey.id] {
                    var worry = monkey.operation.perform(input: item)
                    worry %= modulus
                    if reduceWorry {
                        worry /= 3
                    }

                    let throwTo = worry.isMultiple(of: monkey.testDivisible) ? monkey.throwTrue : monkey.throwFalse
                    items[throwTo].append(worry)
                }
                items[monkey.id].removeAll(keepingCapacity: true)
            }
        }

        return inspectCounts.sorted(by: >).prefix(2).reduce(1, *)
    }
}
