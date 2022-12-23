//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/23
//

import AoCTools

final class Day23: AOCDay {
    private let initialElves: Set<Point>

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput
        var elves = Set<Point>()
        for (y, line) in input.lines.enumerated() {
            for (x, ch) in line.enumerated() {
                if ch == "#" {
                    elves.insert(Point(x, y))
                }
            }
        }
        self.initialElves = elves
    }

    func part1() -> Int {
        var elves = initialElves
        var checks: [[Point.Direction]] = [
            [.n, .nw, .ne],
            [.s, .sw, .se],
            [.w, .nw, .sw],
            [.e, .ne, .se]
        ]

        for _ in 1...10 {
            elves = move(elves, checks)
            checks.append(checks.removeFirst())
        }

        let minX = elves.min { $0.x < $1.x }!.x
        let maxX = elves.max { $0.x < $1.x }!.x
        let minY = elves.min { $0.y < $1.y }!.y
        let maxY = elves.max { $0.y < $1.y }!.y
        let size = (maxX - minX + 1) * (maxY - minY + 1)

        return size - elves.count
    }

    func part2() -> Int {
        var elves = initialElves
        var checks: [[Point.Direction]] = [
            [.n, .nw, .ne],
            [.s, .sw, .se],
            [.w, .nw, .sw],
            [.e, .ne, .se]
        ]

        for round in 1...Int.max {
            let movedElves = move(elves, checks)
            if movedElves == elves {
                return round
            }
            elves = movedElves
            checks.append(checks.removeFirst())
        }

        fatalError()
    }

    private func move(_ elves: Set<Point>, _ checks: [[Point.Direction]]) -> Set<Point> {
        var plannedMoves = [Point: [Point]]()
        var stay = Set<Point>()
        for elf in elves.sorted(by: <) {
            let neighbor = elf.neighbors(adjacency: .all).first { elves.contains($0) }
            if neighbor != nil, let move = proposedMove(for: elf, elves: elves, checks) {
                plannedMoves[move, default: []].append(elf)
            } else {
                stay.insert(elf)
            }
        }

        var movedElves = stay
        for (moveTo, moveFrom) in plannedMoves {
            if moveFrom.count == 1 {
                movedElves.insert(moveTo)
            } else {
                movedElves.formUnion(moveFrom)
            }
        }

        assert(movedElves.count == elves.count)
        return movedElves
    }

    private func proposedMove(for elf: Point, elves: Set<Point>, _ checks: [[Point.Direction]]) -> Point? {
        for check in checks {
            if let move = checkIfNeighborsEmpty(point: elf, directions: check, elves: elves) {
                return move
            }
        }
        return nil
    }

    private func checkIfNeighborsEmpty(point: Point, directions: [Point.Direction], elves: Set<Point>) -> Point? {
        let allEmpty = directions.allSatisfy { !elves.contains(point.moved(to: $0)) }
        return allEmpty ? point.moved(to: directions[0]) : nil
    }
}
