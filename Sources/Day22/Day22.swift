//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/22
//

import AoCTools
import RegexBuilder

private enum Tile: Character, Drawable {
    case floor = "."
    case wall = "#"
}

private enum Move {
    case right
    case left
    case straight(Int)

    static func parse(_ str: String) -> [Move] {
        var moves = [Move]()
        var value = 0
        for ch in str {
            if ch == "R" || ch == "L" {
                moves.append(.straight(value))
                value = 0
                moves.append(ch == "R" ? .right : .left)
            } else {
                value *= 10
                value += Int(String(ch))!
            }
        }
        if value > 0 {
            moves.append(.straight(value))
        }
        return moves
    }
}

private struct Map {
    let points: [Point: Tile]
    let minX: Int
    let maxX: Int
    let minY: Int
    let maxY: Int
    let rowMinMax: [Int: (min: Int, max: Int)]    // min/max X for each Y
    let columnMinMax: [Int: (min: Int, max: Int)] // min/max Y for each X

    init(points: [Point: Tile], cubeSize: Int) {
        self.points = points
        minX = points.keys.min(of: \.x)!
        maxX = points.keys.max(of: \.x)!
        minY = points.keys.min(of: \.y)!
        maxY = points.keys.max(of: \.y)!

        var rowMinMax = [Int: (Int, Int)]()
        for y in minY ... maxY {
            let minX = points.keys.filter { $0.y == y }.min(of: \.x)!
            let maxX = points.keys.filter { $0.y == y }.max(of: \.x)!
            rowMinMax[y] = (min: minX, max: maxX)
        }
        self.rowMinMax = rowMinMax

        var columnMinMax = [Int: (Int, Int)]()
        for x in minX ... maxX {
            let minY = points.keys.filter { $0.x == x }.min(of: \.y)!
            let maxY = points.keys.filter { $0.x == x }.max(of: \.y)!
            columnMinMax[x] = (min: minY, max: maxY)
        }
        self.columnMinMax = columnMinMax
    }

    static func parse(_ lines: [String], cubeSize: Int) -> Map {
        var points = [Point: Tile]()
        for (y, line) in lines.enumerated() {
            for (x, ch) in line.enumerated() {
                if let tile = Tile(rawValue: ch) {
                    let point = Point(x, y)
                    points[point] = tile
                }
            }
        }

        return Map(points: points, cubeSize: cubeSize)
    }

    func draw() {
        for y in minY ... maxY {
            for x in minX ... maxX {
                var ch: Character = " "
                if let t = points[Point(x, y)] {
                    ch = t.rawValue
                }
                print(ch, terminator: "")
            }
            print()
        }
    }
}

final class Day22: AOCDay {
    private let map: Map
    private let moves: [Move]

    convenience init(rawInput: String? = nil) {
        self.init(rawInput: rawInput, cubeSize: 50)
    }

    init(rawInput: String? = nil, cubeSize: Int) {
        let input = rawInput ?? Self.rawInput
        let blocks = input.lines.split(whereSeparator: \.isEmpty)
        map = Map.parse(blocks[0].map { String($0) }, cubeSize: cubeSize)
        moves = Move.parse(blocks[1].first!)
    }

    func part1() -> Int {
        let start = Point(map.rowMinMax[0]!.min, 0)

        var direction = Point.Direction.e
        var current = start

        for move in moves {
            switch move {
            case .straight(let steps):
                for _ in 0..<steps {
                    let next = current.moved(to: direction)
                    switch map.points[next] {
                    case .floor:
                        current = next
                    case .wall:
                        () // do nothing, we're stuck
                    case .none:
                        // check wraparound
                        let wrap: Point
                        switch direction {
                        case .n:
                            wrap = Point(current.x, map.columnMinMax[current.x]!.max)
                        case .s:
                            wrap = Point(current.x, map.columnMinMax[current.x]!.min)
                        case .w:
                            wrap = Point(map.rowMinMax[current.y]!.max, current.y)
                        case .e:
                            wrap = Point(map.rowMinMax[current.y]!.min, current.y)
                        default: fatalError()
                        }
                        if map.points[wrap] == .floor {
                            current = wrap
                        }
                    }
                }
            case .right:
                direction = direction.turned(.clockwise)
            case .left:
                direction = direction.turned(.counterclockwise)
            }
        }

        // Facing is 0 for right (>), 1 for down (v), 2 for left (<), and 3 for up (^).
        let facing: [Point.Direction: Int] = [.e: 0, .s: 1, .w: 2, .n: 3]
        return (current.y + 1) * 1000 + (current.x + 1) * 4 + facing[direction]!
    }

    func part2() -> Int {
        return 0
    }
}
