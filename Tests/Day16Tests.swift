import XCTest
@testable import AdventOfCode

final class Day16Tests: XCTestCase {
    func testDay16_1() throws {
        let day = Day16(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay16_2() throws {
        let day = Day16(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
