//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/15
//

import AoCTools
@preconcurrency import RegexBuilder

private struct Sensor {
    let position: Point
    let beacon: Point
    let range: Int

    static let number = Capture {
        Optionally("-")
        ZeroOrMore(.digit)
    } transform: { Int($0)! }

    nonisolated(unsafe) static let regex = Regex {
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

    func xRange(atY y: Int) -> ClosedRange<Int>? {
        guard (position.y - range) ... (position.y + range) ~= y else {
            return nil
        }

        let delta = abs(y - position.y)
        return position.x - range + delta ... position.x + range - delta
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

final class Day15: AdventOfCodeDay {
    let title = "Beacon Exclusion Zone"
    
    private let sensors: [Sensor]
    private let row: Int
    private let size: Int

    convenience init(input: String) {
        self.init(input: input, row: 2000000, size: 4000000)
    }

    init(input: String, row: Int, size: Int) {
        self.row = row
        self.size = size
        self.sensors = input.lines.map { Sensor($0) }
    }

    func part1() -> Int {
        var count = 0

        let ranges = combineRanges(sensors.compactMap { $0.xRange(atY: row) })
        for range in ranges {
            count += range.upperBound - range.lowerBound - 1
        }
        let occupied =
            sensors.map { $0.position }.filter { $0.y == row } +
            sensors.map { $0.beacon }.filter { $0.y == row }
        return count + Set(occupied).count
    }

    private func combineRanges(_ ranges: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
        var combined = [ClosedRange<Int>]()
        var accumulator = (0...0)

        for range in ranges.sorted(by: { $0.lowerBound  < $1.lowerBound  } ) {
            if accumulator == (0...0) {
                accumulator = range
            }

            if accumulator.upperBound >= range.upperBound {
                // already inside
                continue
            } else if accumulator.upperBound >= range.lowerBound  {
                // extend end
                accumulator = (accumulator.lowerBound...range.upperBound)
            } else if accumulator.upperBound <= range.lowerBound  {
                // no overlap
                combined.append(accumulator)
                accumulator = range
            }
        }

        if accumulator != (0...0) {
            combined.append(accumulator)
        }

        return combined
    }

    func part2() -> Int {
        var borders = [Point]()
        let totalRange = sensors.map { $0.range }.reduce(0, +)
        borders.reserveCapacity(totalRange * 4)

        for sensor in sensors {
            let n = sensor.position + Direction.n.offset * (sensor.range + 1)
            let w = sensor.position + Direction.w.offset * (sensor.range + 1)
            let s = sensor.position + Direction.s.offset * (sensor.range + 1)
            let e = sensor.position + Direction.e.offset * (sensor.range + 1)
            let corners = [n,w,s,e,n]

            for p in zip(corners, corners.dropFirst()) {
                addPoints(from: p.0, to: p.1, to: &borders)
            }
        }

        for borderPoint in borders {
            if !borderPoint.isInRange(of: sensors) {
                return borderPoint.x * 4000000 + borderPoint.y
            }
        }

        fatalError()
    }

    private func addPoints(from start: Point, to end: Point, to result: inout [Point]) {
        let dx = (end.x - start.x).signum()
        let dy = (end.y - start.y).signum()
        let range = abs(start.x - end.x)
        for step in 0 ..< range {
            let p = Point(start.x + dx * step, start.y + dy * step)
            if p.x >= 0 && p.x <= size && p.y >= 0 && p.y <= size {
                result.append(p)
            }
        }
    }
}
