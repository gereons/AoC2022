//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/10
//

import AoCTools

private enum Instruction {
    case noop
    case addx(Int)

    init(_ str: String) {
        let parts = str.components(separatedBy: " ")
        switch parts[0] {
        case "noop": self = .noop
        case "addx": self = .addx(Int(parts[1])!)
        default: fatalError()
        }
    }
}

private class CPU {
    let program: [Instruction]
    private var x = 1
    private var cycle = 1

    init(program: [Instruction]) {
        self.program = program
    }

    func findSignalStrength() -> Int {
        var strength = 0
        run {
            if (cycle-20).isMultiple(of: 40) {
                strength += cycle * x
            }
        }
        return strength
    }

    func render() -> String {
        var crt = [[Character]](repeating: [Character](repeating: ".", count: 40), count: 6)
        var crtX = 0
        var crtY = 0

        run {
            if (crtX-1)...(crtX+1) ~= x {
                crt[crtY][crtX] = "#"
            }
            crtX += 1
            if crtX >= 40 {
                crtX = 0
                crtY += 1
            }
        }

        return crt
            .map { String($0) }
            .joined(separator: "\n")
    }

    private func run(step: () -> Void) {
        for instruction in program {
            step()
            cycle += 1
            switch instruction {
            case .noop:
                continue
            case .addx(let add):
                step()
                cycle += 1
                x += add
            }
        }
    }
}

final class Day10: AOCDay {
    private let program: [Instruction]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput
        program = input.lines.map { Instruction($0) }
    }

    func part1() -> Int {
        let cpu = CPU(program: program)
        let results = cpu.findSignalStrength()
        return results
    }

    func part2() -> String {
        let cpu = CPU(program: program)
        let crt = cpu.render()
        // "PAPKFKEJ"
        return "\n" + crt
    }
}
