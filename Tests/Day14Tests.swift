import XCTest
@testable import AdventOfCode

final class Day14Tests: XCTestCase {
    func testDay14_1() throws {
        let day = Day14(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay14_2() throws {
        let day = Day14(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
