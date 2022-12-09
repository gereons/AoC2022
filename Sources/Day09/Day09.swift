//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/9
//

import AoCTools

private struct Motion {
    let dir: Point.Direction
    let dist: Int

    init(_ str: String) {
        let parts = str.components(separatedBy: " ")
        dist = Int(parts[1])!
        switch parts[0] {
        case "U": dir = .n
        case "L": dir = .w
        case "R": dir = .e
        case "D": dir = .s
        default: fatalError()
        }
    }
}

final class Day09: AOCDay {
    private let motions: [Motion]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput
        motions = input.lines.map { Motion($0) }
    }

    func part1() -> Int {
        var head = Point.zero
        var tail = head
        var visited = Set<Point>()

        for motion in motions {
            for _ in 0 ..< motion.dist {
                head = head.moved(motion.dir)
                let dx = head.x - tail.x
                let dy = head.y - tail.y
                if abs(dx) > 1 || abs(dy) > 1 {
                    // move tail
                    if dx == 0 || dy == 0 {
                        tail = tail.moved(motion.dir)
                    } else {
                        if abs(dx) == 2 {
                            tail = Point(head.x - dx.signum(), head.y)
                        } else if abs(dy) == 2 {
                            tail = Point(head.x, head.y - dy.signum())
                        } else {
                            fatalError()
                        }
                    }
                }
                visited.insert(tail)
            }
        }

        return visited.count
    }

    func part2() -> Int {
        return 0
    }

    private func draw(head: Point, tail: Point, visited: Set<Point>) {
        let minX = min(head.x, tail.x, visited.map { $0.x }.min()! )
        let minY = min(head.y, tail.y, visited.map { $0.y }.min()! )
        let maxX = max(head.x, tail.x, visited.map { $0.x }.max()! )
        let maxY = max(head.y, tail.y, visited.map { $0.y }.max()! )

        for y in minY...maxY {
            for x in minX...maxX {
                let p = Point(x, y)
                let ch: Character
                if p == head {
                    ch = "H"
                } else if p == tail {
                    ch = "T"
                } else if p == .zero {
                    ch = "s"
                } else {
                    ch = "."
                }
                print(ch, terminator: "")
            }
            print()
        }
    }
}
