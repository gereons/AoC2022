import XCTest
@testable import AdventOfCode

final class Day14Tests: XCTestCase {
    func testDay14_1() throws {
        let day = Day14(input: """
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
""")
        XCTAssertEqual(day.part1(), 24)
    }

    func testDay14_2() throws {
        let day = Day14(input: """
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
""")
        XCTAssertEqual(day.part2(), 93)
    }
}
