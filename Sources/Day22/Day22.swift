//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/22
//

import AoCTools
import Foundation

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
    let cubeSize: Int

    init(points: [Point: Tile]) {
        self.points = points
        self.cubeSize = Int(sqrt(Double(points.count / 6)))
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

    static func parse(_ lines: [String]) -> Map {
        var points = [Point: Tile]()
        for (y, line) in lines.enumerated() {
            for (x, ch) in line.enumerated() {
                if let tile = Tile(rawValue: ch) {
                    let point = Point(x, y)
                    points[point] = tile
                }
            }
        }

        return Map(points: points)
    }

    func face(for point: Point) -> Int {
        assert(points[point] != nil)
        if point.y < cubeSize {
            return 1
        }
        if point.y < cubeSize * 2 {
            return (point.x / cubeSize) + 2
        }
        return (point.x / cubeSize) + 3
    }

    func normalize(_ point: Point) -> Point {
        point - offset(for: point)
    }

    // how far is the "origin" of each face from 0,0
    func offset(for point: Point) -> Point {
        offset(for: face(for: point))
    }

    func offset(for face: Int) -> Point {
        switch face {
        case 1: return Point(2 * cubeSize, 0)
        case 2: return Point(0, cubeSize)
        case 3: return Point(cubeSize, cubeSize)
        case 4: return Point(2 * cubeSize, cubeSize)
        case 5: return Point(2 * cubeSize, 2 * cubeSize)
        case 6: return Point(3 * cubeSize, 2 * cubeSize)
        default: fatalError()
        }
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

extension Direction {
    // Facing is 0 for right (>), 1 for down (v), 2 for left (<), and 3 for up (^).
    var facing: Int {
        switch self {
        case .e: return 0
        case .s: return 1
        case .w: return 2
        case .n: return 3
        default: fatalError()
        }
    }
}

final class Day22: AOCDay {
    private let map: Map
    private let moves: [Move]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput
        let blocks = input.lines.split(whereSeparator: \.isEmpty)
        map = Map.parse(blocks[0].map { String($0) })
        moves = Move.parse(blocks[1].first!)
    }

    func part1() -> Int {
        let start = Point(map.rowMinMax[0]!.min, 0)
        print(map.face(for: start))
        let (destination, direction) = walkOnMap(start: start, direction: .e, wrap: wrapOnFlatMap)

        return (destination.y + 1) * 1000 + (destination.x + 1) * 4 + direction.facing
    }

    func part2() -> Int {
        return 0
    }

    private func walkOnMap(start: Point,
                           direction: Direction,
                           wrap: (Point, Direction) -> (Point, Direction)
    ) -> (Point, Direction) {
        var walkTo = start
        var direction = direction

        for move in moves {
            switch move {
            case .straight(let steps):
                for _ in 0..<steps {
                    let next = walkTo.moved(to: direction)
                    switch map.points[next] {
                    case .floor:
                        walkTo = next
                    case .wall:
                        // do nothing, we're stuck
                        break
                    case .none:
                        // check wraparound
                        let (wrap, newDirection) = wrap(walkTo, direction)
                        if map.points[wrap] == .floor {
                            walkTo = wrap
                            direction = newDirection
                        } else {
                            break
                        }
                    }
                }
            case .right:
                direction = direction.turned(.clockwise)
            case .left:
                direction = direction.turned(.counterclockwise)
            }
        }
        return (walkTo, direction)
    }

    private func wrapOnFlatMap(point: Point, direction: Direction) -> (Point, Direction) {
        let wrap: Point
        switch direction {
        case .n: wrap = Point(point.x, map.columnMinMax[point.x]!.max)
        case .s: wrap = Point(point.x, map.columnMinMax[point.x]!.min)
        case .w: wrap = Point(map.rowMinMax[point.y]!.max, point.y)
        case .e: wrap = Point(map.rowMinMax[point.y]!.min, point.y)
        default: fatalError()
        }
        return (wrap, direction)
    }

    func wrapOnCube(point: Point, direction: Direction) -> (Point, Direction) {
        let wrap: Point
        var direction = direction
        let cubeSize = map.cubeSize
        let nPoint = map.normalize(point)
        assert(0..<cubeSize ~= nPoint.x)
        assert(0..<cubeSize ~= nPoint.y)

        switch (map.face(for: point), direction) {
        case (1, .n): // to 2N, turn S
            wrap = Point(cubeSize - 1 - nPoint.x, 0) + map.offset(for: 2)
            assert(map.face(for: wrap) == 2)
            direction = .s
        case (2, .n): // to 1N, turn S
            wrap = Point(cubeSize - 1 - nPoint.x, 0) + map.offset(for: 1)
            assert(map.face(for: wrap) == 1)
            direction = .s

        case (1, .w): // to 3N, turn S
            wrap = Point(nPoint.y, nPoint.x) + map.offset(for: 3)
            assert(map.face(for: wrap) == 3)
            direction = .s
        case (3, .n): // to 1W, turn E
            wrap = Point(nPoint.y, nPoint.x) + map.offset(for: 1)
            assert(map.face(for: wrap) == 1)
            direction = .e


        case (1, .e): // to 6E, turn W
            wrap = Point(nPoint.y, nPoint.x) + map.offset(for: 6)
            assert(map.face(for: wrap) == 6)
            direction = .w
        case (6, .e): // to 1W, turn E
            wrap = Point(nPoint.x, cubeSize - 1 - nPoint.y) + map.offset(for: 1)
            assert(map.face(for: wrap) == 1)
            direction = .e





        case (2, .w): // to 6S, turn N XXX
            assert(point.x == cubeSize)
            wrap = Point(point.x + 3 * cubeSize, 3 * cubeSize - 1)
            assert(map.face(for: wrap) == 6)
            direction = .n
        case (2, .s): // to 5S, turn N
            wrap = Point(point.x + 2 * cubeSize, 3 * cubeSize - 1)
            assert(map.face(for: wrap) == 5)
            direction = .n

        default:
            fatalError()
        }

        assert(map.points[wrap] != nil)
        return (wrap, direction)
    }
}
