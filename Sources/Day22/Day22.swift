//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/22
//
// for part 2 I gave up after failing to figure out the cube mappings and ported
// https://github.com/cheng93/AdventOfCode/blob/master/Solutions/2022/AdventOfCode2022/Day22/Day22Solver.cs
// to swift
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
}

private struct CubeMap {
    let segments: [Point: [Point: Tile]]
    let faceSegment: [Face: Point]
    let faceOffset: [Face: Int]
    let start: Point
    let cubeSize: Int

    static func parse(_ lines: [String], cubeSize: Int) -> CubeMap {
        var segments = [Point: [Point: Tile]]()
        var start: Point?

        for j in 0..<lines.count / cubeSize {
            let jFactor = j * cubeSize
            for i in 0..<lines[jFactor].count / cubeSize {
                let iFactor = i * cubeSize
                let segment = Point(i, j)

                for y in 0 ..< cubeSize {
                    let line = lines[jFactor + y]
                    for (x, ch) in line[iFactor ..< iFactor + cubeSize].enumerated() {
                        if let tile = Tile(rawValue: ch) {
                            let point = Point(x, y)
                            segments[segment, default: [:]][point] = tile

                            if start == nil {
                                start = point
                            }
                        }
                    }
                }
            }
        }

        var faceSegment = [Face: Point]()
        var faceOffset = [Face: Int]()

        var queue = [QueueEntry]()
        var visited = Set<Point>()

        let startSegment = segments.keys.sorted().first!
        queue.append(QueueEntry(segment: startSegment, face: .front, fromDirection: .s, fromFace: .top))
        visited.insert(startSegment)

        while !queue.isEmpty {
            let current = queue.removeFirst()
            faceSegment[current.face] = current.segment
            let relativeFrom = current.fromDirection.opposite
            let offset = (4 + relativeFrom.facing - Face.neighbors[current.face]!.firstIndex(of: current.fromFace)!) % 4
            faceOffset[current.face] = offset

            for direction in [Direction.e, .s, .w, .n] {
                // let direction = Direction(i)
                let segment = Point(current.segment.x + direction.offset.x, current.segment.y + direction.offset.y)
                if segments.keys.contains(segment) && !visited.contains(segment) {
                    visited.insert(segment)
                    let nextFace = Face.neighbors[current.face]![(4 + direction.facing - offset) % 4]
                    queue.append(QueueEntry(segment: segment, face: nextFace, fromDirection: direction, fromFace: current.face))
                }
            }
        }

        return CubeMap(segments: segments, faceSegment: faceSegment, faceOffset: faceOffset, start: start!, cubeSize: cubeSize)
    }

    private struct QueueEntry {
        let segment: Point
        let face: Face
        let fromDirection: Direction
        let fromFace: Face
    }
}

private enum Face {
    case front, back, left, right, top, bottom

    static let neighbors: [Face: [Face]] = [
        .front: [ right, bottom, left, top ],
        .back: [ left, bottom, right, top ],
        .left: [ front, bottom, back, top ],
        .right: [ back, bottom, front, top ],
        .top: [right, front, left, back ],
        .bottom: [ right, back, left, front ]
    ]
}

fileprivate extension Direction {
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
    private let cubeMap: CubeMap
    private let moves: [Move]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput
        let blocks = input.lines.split(whereSeparator: \.isEmpty)
        let mapLines = blocks[0].map { String($0) }
        map = Map.parse(mapLines)
        cubeMap = CubeMap.parse(mapLines, cubeSize: map.cubeSize)
        moves = Move.parse(blocks[1].first!)
    }

    func part1() -> Int {
        let start = Point(map.rowMinMax[0]!.min, 0)
        let (destination, direction) = walkOnMap(start: start, direction: .e)

        return (destination.y + 1) * 1000 + (destination.x + 1) * 4 + direction.facing
    }

    func part2() -> Int {
        return walkOnCube(start: cubeMap.start, direction: .e, face: .front)
    }

    private func walkOnMap(start: Point, direction: Direction) -> (Point, Direction) {
        var current = start
        var direction = direction

        for move in moves {
            switch move {
            case .straight(let steps):
                for _ in 0..<steps {
                    let next = current.moved(to: direction)
                    switch map.points[next] {
                    case .floor:
                        current = next
                    case .wall:
                        // do nothing, we're stuck
                        break
                    case .none:
                        // check wraparound
                        let wrap: Point
                        switch direction {
                        case .n: wrap = Point(next.x, map.columnMinMax[next.x]!.max)
                        case .s: wrap = Point(next.x, map.columnMinMax[next.x]!.min)
                        case .w: wrap = Point(map.rowMinMax[next.y]!.max, next.y)
                        case .e: wrap = Point(map.rowMinMax[next.y]!.min, next.y)
                        default: fatalError()
                        }
                        if map.points[wrap] == .floor {
                            current = wrap
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
        return (current, direction)
    }

    private func walkOnCube(start: Point, direction: Direction, face: Face) -> Int {
        var current = start
        var direction = direction
        var face = face

        for move in moves {
            switch move {
            case .straight(let steps):
                for _ in 0..<steps {
                    var newDirection = direction
                    var next = current.moved(to: direction)
                    var newFace = face
                    var valid = true
                    if cubeMap.segments[cubeMap.faceSegment[face]!]![next] == .wall {
                        break
                    }
                    if cubeMap.segments[cubeMap.faceSegment[face]!]![next] == nil {
                        let directionIndex = direction.facing
                        newFace = Face.neighbors[face]![(4 + directionIndex - cubeMap.faceOffset[face]!) % 4]
                        next = current
                        let relativeFrom = direction.opposite.facing
                        let positionOffset = (4 + Face.neighbors[newFace]!.firstIndex(of: face)! - relativeFrom) % 4
                        let offset = cubeMap.faceOffset[newFace]!
                        let rotations = (positionOffset + offset) % 4

                        for _ in 0 ..< rotations {
                            newDirection = newDirection.turned(.clockwise)
                            next = Point(cubeMap.cubeSize - 1 - next.y, next.x)
                        }

                        switch newDirection {
                        case .e: next = Point(0, next.y)
                        case .s: next = Point(next.x, 0)
                        case .w: next = Point(cubeMap.cubeSize - 1, next.y)
                        case .n: next = Point(next.x, cubeMap.cubeSize - 1)
                        default: fatalError()
                        }

                        let tile = cubeMap.segments[cubeMap.faceSegment[newFace]!]![next]
                        assert(tile != nil)
                        valid = tile  == .floor
                    }
                    if !valid {
                        break
                    }
                    current = next
                    face = newFace
                    direction = newDirection
                }
            case .right:
                direction = direction.turned(.clockwise)
            case .left:
                direction = direction.turned(.counterclockwise)
            }
        }

        let segment = cubeMap.faceSegment[face]!
        let column = segment.x * cubeMap.cubeSize + current.x + 1
        let row = segment.y * cubeMap.cubeSize + current.y + 1

        return 1000 * row + 4 * column + direction.facing
    }
}
