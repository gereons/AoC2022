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

    static let number = Capture {
        Optionally("-")
        ZeroOrMore(.digit)
    } transform: { Int($0)! }

    static let regex = Regex {
        "Sensor at x="
        number
        ", y="
        number
        ": closest beacon is at x="
        number
        ", y="
        number
    }

    init(_ str: String) {
        // Sensor at x=2, y=18: closest beacon is at x=-2, y=15

        let matches = try! Self.regex.wholeMatch(in: str)!.output
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

private extension Point {
    func isInRange(of sensors: [Sensor]) -> Bool {
        for sensor in sensors {
            if distance(to: sensor.position) <= sensor.range {
                return true
            }
        }
        return false
    }

    func isOccupiedOrInRange(of sensors: [Sensor]) -> Bool {
        for sensor in sensors {
            if self == sensor.position || self == sensor.beacon {
                return false
            }
            if distance(to: sensor.position) <= sensor.range {
                return true
            }
        }
        return false
    }
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
            if point.isOccupiedOrInRange(of: sensors) {
                count += 1
            }
        }
        return count
    }

    func part2() -> Int {
        var borders = [Point]()
        let totalRange = sensors.map { $0.range }.reduce(0, +)
        borders.reserveCapacity(totalRange * 4)

        for sensor in sensors {
            let n = sensor.position + Point.Direction.n.offset * (sensor.range + 1)
            let w = sensor.position + Point.Direction.w.offset * (sensor.range + 1)
            let s = sensor.position + Point.Direction.s.offset * (sensor.range + 1)
            let e = sensor.position + Point.Direction.e.offset * (sensor.range + 1)
            let corners = [n,w,s,e,n]

            for p in zip(corners, corners.dropFirst()) {
                let border = points(from: p.0, to: p.1)
                    .filter {
                        $0.x >= 0 && $0.x <= size &&
                        $0.y >= 0 && $0.y <= size
                    }
                borders.append(contentsOf: border)
            }
        }

        for borderPoint in borders {
            if !borderPoint.isInRange(of: sensors) {
                return borderPoint.x * 4000000 + borderPoint.y
            }
        }

        fatalError()
    }

    private func points(from start: Point, to end: Point) -> [Point] {
        var result = [Point]()

        let dx = (end.x - start.x).signum()
        let dy = (end.y - start.y).signum()
        let range = abs(start.x - end.x)
        result.reserveCapacity(range)
        result = (0..<range).map { step in
            Point(start.x + dx * step, start.y + dy * step)
        }
        return result
    }
}
