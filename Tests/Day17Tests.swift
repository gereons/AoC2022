import XCTest
@testable import AdventOfCode

final class Day17Tests: XCTestCase {
    func testDay17_1() throws {
        let day = Day17(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay17_2() throws {
        let day = Day17(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
