//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/15
//

import AoCTools
import RegexBuilder

private struct Sensor {
    let position: Point
    let beacon: Point
    let range: Int

    init(_ str: String) {
        // Sensor at x=2, y=18: closest beacon is at x=-2, y=15
        let number = Capture {
            Optionally("-")
            ZeroOrMore(.digit)
        } transform: { Int($0)! }

        let regex = Regex {
            "Sensor at x="
            number
            ", y="
            number
            ": closest beacon is at x="
            number
            ", y="
            number
        }

        let matches = try! regex.wholeMatch(in: str)!.output
        position = Point(matches.1, matches.2)
        beacon = Point(matches.3, matches.4)
        range = position.distance(to: beacon)
    }
}

private enum Tile: Character, Drawable {
    case sensor = "S"
    case beacon = "B"
    case empty = "#"
}

final class Day15: AOCDay {
    private let sensors: [Sensor]
    private let row: Int
    private let size: Int

    convenience init(rawInput: String? = nil) {
        self.init(rawInput: rawInput, row: 2000000, size: 4000000)
    }

    init(rawInput: String? = nil, row: Int, size: Int) {
        let input = rawInput ?? Self.rawInput

        self.row = row
        self.size = size
        self.sensors = input.lines.map { Sensor($0) }
    }

    func part1() -> Int {
        var grid = [Point: Tile]()
        var maxX = Int.min
        var minX = Int.max
        for sensor in sensors {
            grid[sensor.position] = .sensor
            grid[sensor.beacon] = .beacon
            maxX = max(maxX, sensor.position.x)
            minX = min(minX, sensor.position.x)
        }
        let leftRange = sensors.filter { $0.position.x == minX }.max(of: \.range)!
        let rightRange = sensors.filter { $0.position.x == maxX }.max(of: \.range)!

        var count = 0
        for x in minX - leftRange ... maxX + rightRange {
            let point = Point(x, row)
            if isInRange(point, sensors) {
                count += 1
            }
        }

        return count
    }

    private func isInRange(_ point: Point, _ sensors: [Sensor]) -> Bool {
        for sensor in sensors {
            if point == sensor.position { return false }
            if point == sensor.beacon { return false }
            if point.distance(to: sensor.position) <= sensor.range { return true }
        }
        return false
    }


    func part2() -> Int {
        var grid = [Point: Tile]()
        var maxX = Int.min
        var minX = Int.max
        for sensor in sensors {
            grid[sensor.position] = .sensor
            grid[sensor.beacon] = .beacon
            maxX = max(maxX, sensor.position.x)
            minX = min(minX, sensor.position.x)
        }
        let leftRange = sensors.filter { $0.position.x == minX }.max(of: \.range)!
        let rightRange = sensors.filter { $0.position.x == maxX }.max(of: \.range)!

        var missing = Point.zero
        for y in 0 ... size {
            print(y)
            for x in max(0, minX - leftRange) ... min(size, maxX + rightRange) {
                let point = Point(x, y)
                if isDistress(point, sensors) {
                    missing = point
                    break
                }
            }
        }

        return missing.x * 4000000 + missing.y
    }

    private func isDistress(_ point: Point, _ sensors: [Sensor]) -> Bool {
        for sensor in sensors {
            if point == sensor.position { return false }
            if point == sensor.beacon { return false }
            if point.distance(to: sensor.position) <= sensor.range { return false }
        }
        return true
    }
}

extension Day15 {
    func part1_naive() -> Int {
        var grid = [Point: Tile]()
        for sensor in sensors {
            grid[sensor.position] = .sensor
            grid[sensor.beacon] = .beacon
        }

        for sensor in sensors {
            let range = sensor.range + 1
            for x in sensor.position.x - range ... sensor.position.x + range {
                for y in sensor.position.y - range ... sensor.position.y + range {
                    let p = Point(x, y)
                    if p.distance(to: sensor.position) < range && grid[p] == nil {
                        grid[p] = .empty
                    }
                }
            }
        }

        // Grid(points: grid).draw()
        let minX = grid.keys.min(of: \.x)!
        let maxX = grid.keys.max(of: \.x)!

        var count = 0
        for x in minX ... maxX {
            if grid[Point(x, row)] == .empty {
                count += 1
            }
        }
        return count
    }

    func part2_naive() -> Int {
        var grid = [Point: Tile]()

        for sensor in sensors {
            grid[sensor.position] = .sensor
            grid[sensor.beacon] = .beacon
        }

        for sensor in sensors {
            let range = sensor.range + 1
            for x in sensor.position.x - range ... sensor.position.x + range {
                for y in sensor.position.y - range ... sensor.position.y + range {
                    let p = Point(x, y)
                    if p.distance(to: sensor.position) < range && grid[p] == nil {
                        grid[p] = .empty
                    }
                }
            }
        }

        grid = grid
            .filter {
                $0.key.x >= 0 && $0.key.x <= size &&
                $0.key.y >= 0 && $0.key.y <= size
            }

        return 0
    }
}
