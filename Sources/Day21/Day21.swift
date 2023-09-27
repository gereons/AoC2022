//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/21
//

import AoCTools

private class Monkey {
    let name: String

    init(name: String) {
        self.name = name
    }

    var yell: Int {
        fatalError("must be overridden")
    }

    func findHumanPath() -> Set<Monkey> {
        fatalError("must be overridden")
    }

    func calculateHumanValue(path: Set<Monkey>, incoming: Int) -> Int {
        fatalError("must be overridden")
    }

    static func make(_ str: String) -> Monkey {
        let parts = str.components(separatedBy: " ")
        let name = String(parts[0].dropLast())
        if let constant = Int(parts[1]) {
            return ConstantMonkey(name: name, constant: constant)
        } else {
            return CalcMonkey(name: name, leftName: parts[1], op: parts[2], rightName: parts[3])
        }
    }
}

extension Monkey: Hashable {
    static func == (lhs: Monkey, rhs: Monkey) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

final private class FailMonkey: Monkey { }

final private class ConstantMonkey: Monkey {
    let constant: Int

    init(name: String, constant: Int) {
        self.constant = constant
        super.init(name: name)
    }

    override var yell: Int {
        constant
    }

    override func findHumanPath() -> Set<Monkey> {
        name == "humn" ? [self] : []
    }

    override func calculateHumanValue(path: Set<Monkey>, incoming: Int) -> Int {
        name == "humn" ? incoming : constant
    }
}

final private class CalcMonkey: Monkey {
    let leftName: String
    let rightName: String
    let op: String
    var left: Monkey = FailMonkey(name: "FAIL")
    var right: Monkey = FailMonkey(name: "FAIL")

    init(name: String, leftName: String, op: String, rightName: String) {
        self.leftName = leftName
        self.op = op
        self.rightName = rightName

        super.init(name: name)
    }

    override var yell: Int {
        switch op {
        case "+": left.yell + right.yell
        case "-": left.yell - right.yell
        case "*": left.yell * right.yell
        case "/": left.yell / right.yell
        default: fatalError()
        }
    }

    override func findHumanPath() -> Set<Monkey> {
        let leftPath = left.findHumanPath()
        let rightPath = right.findHumanPath()
        if !leftPath.isEmpty {
            return leftPath + [self]
        } else if !rightPath.isEmpty {
            return rightPath + [self]
        } else {
            return []
        }
    }

    override func calculateHumanValue(path: Set<Monkey>, incoming: Int) -> Int {
        if name == "root" {
            if path.contains(left) {
                return left.calculateHumanValue(path: path, incoming: right.yell)
            } else {
                return right.calculateHumanValue(path: path, incoming: left.yell)
            }
        } else if path.contains(left) {
            return left.calculateHumanValue(path: path, incoming: leftReverseOp(incoming, right.yell))
        } else {
            return right.calculateHumanValue(path: path, incoming: rightReverseOp(incoming, left.yell))
        }
    }

    func leftReverseOp(_ lhs: Int, _ rhs: Int) -> Int {
        switch self.op {
        case "+": lhs - rhs
        case "-": lhs + rhs
        case "*": lhs / rhs
        case "/": lhs * rhs
        default: fatalError()
        }
    }

    func rightReverseOp(_ lhs: Int, _ rhs: Int) -> Int {
        switch self.op {
        case "+": lhs - rhs
        case "-": rhs - lhs
        case "*": lhs / rhs
        case "/": rhs / lhs
        default: fatalError()
        }
    }
}

final class Day21: AOCDay {
    private let monkeys: Set<Monkey>
    private let root: Monkey

    init(input: String? = nil) {
        let input = input ?? Self.input

        let allMonkeys = input.lines.map { Monkey.make($0) }.mapped(by: \.name)
        for monkey in allMonkeys.values.compactMap({ $0 as? CalcMonkey }) {
            monkey.left = allMonkeys[monkey.leftName]!
            monkey.right = allMonkeys[monkey.rightName]!
        }

        monkeys = Set(allMonkeys.values)
        root = allMonkeys["root"]!
    }

    func part1() -> Int {
        root.yell
    }

    func part2() -> Int {
        let path = root.findHumanPath()
        return root.calculateHumanValue(path: path, incoming: 0)
    }
}
