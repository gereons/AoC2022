import XCTest
@testable import AdventOfCode

final class Day21Tests: XCTestCase {
    func testDay21_1() throws {
        let day = Day21(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay21_2() throws {
        let day = Day21(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
