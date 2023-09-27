//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/14
//

import AoCTools

private enum Unit: Character, Drawable {
    case wall = "#"
    case sand = "o"
    case source = "+"
}

final class Day14: AOCDay {
    private let cave: [Point: Unit]

    init(input: String? = nil) {
        let input = input ?? Self.input

        var cave = [Point: Unit]()
        for line in input.lines {
            let parts = line.components(separatedBy: " -> ")
            var prev: Point?
            for part in parts {
                let xy = part.components(separatedBy: ",")
                let point = Point(Int(xy[0])!, Int(xy[1])!)
                cave[point] = .wall
                if let prev {
                    let dx = (point.x - prev.x).signum()
                    let dy = (point.y - prev.y).signum()
                    let steps = max(abs(point.x - prev.x), abs(point.y - prev.y))
                    (0..<steps).forEach { step in
                        cave[Point(prev.x + dx * step, prev.y + dy * step)] = .wall
                    }
                }
                prev = point
            }
        }
        self.cave = cave        
    }

    func part1() -> Int {
        var cave = self.cave
        let source = Point(500, 0)
        cave[source] = .source
        let maxY = cave.keys.max(of: \.y)!

        var cameToRest = true
        while cameToRest {
            cameToRest = dropSand(from: source, into: &cave, maxY: maxY)
        }

        return cave.values.count(where: { $0 == .sand} )
    }

    func part2() -> Int {
        var cave = self.cave
        let source = Point(500, 0)
        cave[source] = .source
        let maxY = cave.keys.max(of: \.y)!

        var filled = false
        while !filled {
            filled = fill(cave: &cave, from: source, floorY: maxY + 2)
        }

        return cave.values.count(where: { $0 == .sand} )
    }

    private func fill(cave: inout [Point: Unit], from start: Point, floorY: Int) -> Bool {
        var next = start
        var prev: Point?
        while next.y < floorY {
            let down = next.moved(to: .s)
            let sw = next.moved(to: .sw)
            let se = next.moved(to: .se)

            if cave[down] == nil {
                prev = next
                next = down
            } else if cave[sw] == nil {
                prev = next
                next = sw
            } else if cave[se] == nil {
                prev = next
                next = se
            } else {
                let unit = cave[next]
                cave[next] = .sand
                if unit == .source {
                    return true
                }
                return false
            }
        }
        if let prev {
            cave[prev] = .sand
        }
        return false
    }

    private func dropSand(from start: Point, into cave: inout [Point: Unit], maxY: Int) -> Bool {
        var next = start
        while next.y <= maxY {
            let down = next.moved(to: .s)
            let sw = next.moved(to: .sw)
            let se = next.moved(to: .se)

            if cave[down] == nil {
                next = down
            } else if cave[sw] == nil {
                next = sw
            } else if cave[se] == nil {
                next = se
            } else {
                cave[next] = .sand
                return true
            }
        }
        return false
    }
}
