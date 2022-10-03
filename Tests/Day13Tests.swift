import XCTest
@testable import AdventOfCode

final class Day13Tests: XCTestCase {
    func testDay13_1() throws {
        let day = Day13(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay13_2() throws {
        let day = Day13(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
