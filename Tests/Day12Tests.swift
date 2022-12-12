import XCTest
@testable import AdventOfCode

final class Day12Tests: XCTestCase {
    func testDay12_1() throws {
        let day = Day12(rawInput: """
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
""")
        XCTAssertEqual(day.part1(), 31)
    }

    func testDay12_2() throws {
        let day = Day12(rawInput: """
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
""")
        XCTAssertEqual(day.part2(), 29)
    }
}
