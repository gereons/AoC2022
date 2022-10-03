import XCTest
@testable import AdventOfCode

final class Day18Tests: XCTestCase {
    func testDay18_1() throws {
        let day = Day18(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay18_2() throws {
        let day = Day18(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
