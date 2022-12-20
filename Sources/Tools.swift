//
// Tools.swift
//  
// Advent of Code
// candidates for inclusion in `AoCTools`
//

import Foundation
import AoCTools
import RegexBuilder

extension String {
    private static let regex = Regex {
        Capture {
            Optionally("-")
            ZeroOrMore(.digit)
        }
    }

    func allInts() -> [Int] {
        let ranges = self.ranges(of: Self.regex)
        return ranges.compactMap { Int(self[$0]) }
    }
}

extension Point {
    func line(to end: Point) -> [Point] {
        let dx = (end.x - x).signum()
        let dy = (end.y - y).signum()
        let range = max(abs(x - end.x), abs(y - end.y))
        return (0 ..< range).map { step in
            Point(x + dx * step, y + dy * step)
        }
    }

    func moved(to direction: Direction, steps: Int) -> Point {
        self + direction.offset * steps
    }
}

extension Array where Element: Hashable {
    func makeSet() -> Set<Element> {
        Set(self)
    }
}
