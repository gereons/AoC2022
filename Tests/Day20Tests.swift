import XCTest
@testable import AdventOfCode

final class Day20Tests: XCTestCase {
    func testDay20_1() throws {
        let day = Day20(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay20_2() throws {
        let day = Day20(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
