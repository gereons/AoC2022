//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/9
//

import AoCTools

private struct Motion {
    let direction: Point.Direction
    let distance: Int

    static let dirMap: [String: Point.Direction] = [
        "U": .n, "L": .w, "R": .e, "D": .s
    ]

    init(_ str: String) {
        let parts = str.components(separatedBy: " ")
        direction = Self.dirMap[parts[0]]!
        distance = Int(parts[1])!
    }
}

final class Day09: AOCDay {
    private let motions: [Motion]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput
        motions = input.lines.map { Motion($0) }
    }

    func part1() -> Int {
        simulateBridge(tailLength: 1)
    }

    func part2() -> Int {
        simulateBridge(tailLength: 9)
    }

    private func simulateBridge(tailLength: Int) -> Int {
        var head = Point.zero
        var tail = [Point](repeating: .zero, count: tailLength)
        var visited = Set<Point>()

        for motion in motions {
            for _ in 0 ..< motion.distance {
                head = head.moved(to: motion.direction)

                var prev = head
                var newTail = [Point]()
                for t in tail {
                    let p = t.follow(prev)
                    prev = p
                    newTail.append(p)
                }

                tail = newTail
                visited.insert(tail.last!)
            }
        }

        return visited.count
    }

    private func draw(head: Point, tail: [Point]) {
        let minX = min(head.x, tail.map { $0.x }.min()!)
        let minY = min(head.y, tail.map { $0.y }.min()!)
        let maxX = max(head.x, tail.map { $0.x }.max()!)
        let maxY = max(head.y, tail.map { $0.y }.max()!)

        for y in minY...maxY {
            for x in minX...maxX {
                let p = Point(x, y)
                let ch: String
                if p == head {
                    ch = "H"
                } else if let index = tail.firstIndex(of: p) {
                    ch = "\(index+1)"
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

extension Point {
    func follow(_ point: Point) -> Point {
        // don't move if we're adjacent
        guard chebyshevDistance(to: point) > 1 else {
            return self
        }

        var newX = point.x
        var newY = point.y
        let dx = point.x - self.x
        let dy = point.y - self.y

        // if we're more than one 1 step away on an axis, move along that axis
        if abs(dx) > 1 {
            newX -= dx.signum()
        }
        if abs(dy) > 1 {
            newY -= dy.signum()
        }
        return Point(newX, newY)
    }
}
