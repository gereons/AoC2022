import XCTest
@testable import AdventOfCode

final class Day06Tests: XCTestCase {
    func testDay06_1() throws {
        let day = Day06(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay06_2() throws {
        let day = Day06(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
