//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/10
//

import AoCTools

private enum Instruction {
    case noop
    case addx(Int)

    static func decode(_ str: String) -> [Instruction] {
        let parts = str.components(separatedBy: " ")
        switch parts[0] {
        case "noop": return [.noop]
        case "addx": return [.noop, .addx(Int(parts[1])!)]
        default: fatalError()
        }
    }
}

private class CPU {
    let program: [Instruction]
    private var x = 1
    private var cycle = 1

    let crtWidth = 40
    let crtHeight = 6

    init(program: [Instruction]) {
        self.program = program
    }

    func findSignalStrength() -> Int {
        var strength = 0
        run {
            if (cycle - 20).isMultiple(of: 40) {
                strength += cycle * x
            }
        }
        return strength
    }

    func render() -> String {
        let line = [Character](repeating: "⬜️", count: crtWidth)
        var crt = [[Character]](repeating: line, count: crtHeight)

        run {
            let (crtY, crtX) = (cycle - 1).quotientAndRemainder(dividingBy: crtWidth)
            if (crtX - 1)...(crtX + 1) ~= x {
                crt[crtY][crtX] = "⬛️"
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
            if case Instruction.addx(let add) = instruction {
                x += add
            }
        }
    }
}

final class Day10: AdventOfCodeDay {
    let title = "Cathode-Ray Tube"
    
    private let program: [Instruction]

    init(input: String) {
        program = input.lines.flatMap { Instruction.decode($0) }
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
        return crt
    }
}
