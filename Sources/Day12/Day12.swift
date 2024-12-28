//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/12
//

import AoCTools

private struct HeightMap {
    let map: [Point: UInt8]
    let start: Point
    let destination: Point
}

final class Day12: AOCDay {
    private let heightMap: HeightMap

    init(input: String) {
        var start = Point.zero
        var destination = Point.zero
        var map = [Point: UInt8]()
        for (y, line) in input.lines.enumerated() {
            for (x, ch) in line.enumerated() {
                var ch = ch
                let point = Point(x, y)
                if ch == "S" {
                    start = point
                    ch = "a"
                }
                if ch == "E" {
                    destination = point
                    ch = "z"
                }
                map[point] = ch.asciiValue!
            }
        }
        self.heightMap = HeightMap(map: map, start: start, destination: destination)
    }

    func part1() -> Int {
        let pathfinder = AStarPathfinder(map: heightMap)
        let path = pathfinder.shortestPath(from: heightMap.start, to: heightMap.destination)
        return path.count
    }

    func part2() -> Int {
        let pathfinder = AStarPathfinder(map: heightMap)
        let starts = heightMap.map
            .filter { $0.value == 97 }.map { $0.key }
            .filter { $0.neighbors().count { heightMap.map[$0] == 98 } > 0 }

        var shortest = Int.max
        for start in starts {
            let path = pathfinder.shortestPath(from: start, to: heightMap.destination)
            if !path.isEmpty {
                shortest = min(shortest, path.count)
            }
        }
        return shortest
    }
}

extension HeightMap: Pathfinding {
    func neighbors(of point: Point) -> [Point] {
        let height = map[point]! + 1
        return point
            .neighbors()
            .filter {
                if let h = map[$0] {
                    return h <= height
                }
                return false
            }
    }
}
