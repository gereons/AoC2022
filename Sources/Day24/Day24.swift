//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/24
//

import AoCTools

private enum Ground: Character, Drawable {
    case wall = "#"
    case open = "."
}

struct Blizzard: Hashable, Equatable {
    let direction: Direction

    init?(dir: Character) {
        switch (dir) {
        case "<": direction = .left
        case ">": direction = .right
        case "^": direction = .up
        case "v": direction = .down
        default: return nil
        }
    }
}

private struct Valley {
    let grid: [Point: Ground]
    let blizzards: [Point: [Blizzard]]
    let maxX: Int
    let maxY: Int
    let start: Point
    let destination: Point
    let blizzardStates: [[Point: [Blizzard]]]

    init(_ str: String) {
        var start = Point.zero
        var destination = Point.zero
        var grid = [Point: Ground]()

        var blizzards = [Point: [Blizzard]]()
        let lines = str.lines
        for (y, line) in lines.enumerated() {
            for (x, ch) in line.enumerated() {
                let point = Point(x, y)
                if let b = Blizzard(dir: ch) {
                    blizzards[point, default: []].append(b)
                }
                if y == 0 && ch == "." { start = point }
                if y == lines.count - 1 && ch == "." { destination = point }
                grid[point] = ch == "#" ? .wall : .open
            }
        }

        maxX = grid.keys.max(of: \.x)!
        maxY = grid.keys.max(of: \.y)!
        self.start = start
        self.destination = destination
        self.grid = grid
        self.blizzards = blizzards

        // precompute all possible blizzard states
        var bStates = [[Point: [Blizzard]]]()
        var seen = Set<[Point: [Blizzard]]>()
        bStates.append(blizzards)
        seen.insert(blizzards)
        for _ in 1..<lcm(maxX - 1, maxY - 1) {
            let moved = Self.move(blizzards, maxX: maxX, maxY: maxY)
            if seen.contains(moved) {
                break
            }
            bStates.append(moved)
            seen.insert(moved)
            blizzards = moved
        }

        self.blizzardStates = bStates
    }

    private static func move(_ blizzards: [Point: [Blizzard]], maxX: Int, maxY: Int) -> [Point: [Blizzard]] {
        var moved = [Point: [Blizzard]]()

        for (point, blizzards) in blizzards {
            for b in blizzards {
                var p = point.moved(to: b.direction)
                if p.x == 0 {
                    p = Point(maxX - 1, p.y)
                } else if p.x == maxX {
                    p = Point(1, p.y)
                } else if p.y == 0 {
                    p = Point(p.x, maxY - 1)
                } else if p.y == maxY {
                    p = Point(p.x, 1)
                }

                moved[p, default: []].append(b)
            }
        }
        return moved
    }
}

final class Day24: AOCDay {
    private let valley: Valley

    init(input: String) {
        valley = Valley(input)
    }

    func part1() -> Int {
        let pathfinder = AStarPathfinder(map: valley)
        let start = PathNode(valley.start)
        let destination = PathNode(valley.destination)
        let path = pathfinder.shortestPath(from: start, to: destination)
        return path.count
    }

    func part2() -> Int {
        let pathfinder = AStarPathfinder(map: valley)

        let path1 = pathfinder.shortestPath(from: PathNode(valley.start),
                                            to: PathNode(valley.destination))
        let path2 = pathfinder.shortestPath(from: PathNode(valley.destination, time: path1.count),
                                            to: PathNode(valley.start))
        let path3 = pathfinder.shortestPath(from: PathNode(valley.start, time: path1.count + path2.count),
                                            to: PathNode(valley.destination))

        return path1.count + path2.count + path3.count
    }
}

private struct PathNode: Hashable {
    let point: Point
    let time: Int

    init(_ point: Point, time: Int = 0) {
        self.point = point
        self.time = time
    }
}

extension Valley: Pathfinding {
    typealias Coordinate = PathNode

    func neighbors(for node: PathNode) -> [PathNode] {
        let moved = blizzardStates[(node.time + 1) % blizzardStates.count]
        let targets = node.point.neighbors() + [node.point] // move or stay
        let neighbors = targets
            .filter { grid[$0] == .open }
            .filter { moved[$0] == nil }

        return neighbors.map { PathNode($0, time: node.time + 1) }
    }

    func costToMove(from: PathNode, to: PathNode) -> Int {
        distance(from: from, to: to) + to.time
    }

    func distance(from: PathNode, to: PathNode) -> Int {
        from.point.distance(to: to.point)
    }

    func goalReached(at node: PathNode, goal: PathNode) -> Bool {
        node.point == goal.point
    }
}
