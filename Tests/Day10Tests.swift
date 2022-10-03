import XCTest
@testable import AdventOfCode

final class Day10Tests: XCTestCase {
    func testDay10_1() throws {
        let day = Day10(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay10_2() throws {
        let day = Day10(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
