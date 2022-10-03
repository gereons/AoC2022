import XCTest
@testable import AdventOfCode

final class Day07Tests: XCTestCase {
    func testDay07_1() throws {
        let day = Day07(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay07_2() throws {
        let day = Day07(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
