import XCTest
@testable import AdventOfCode

final class Day24Tests: XCTestCase {
    func testDay24_1() throws {
        let day = Day24(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay24_2() throws {
        let day = Day24(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
