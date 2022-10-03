import XCTest
@testable import AdventOfCode

final class Day11Tests: XCTestCase {
    func testDay11_1() throws {
        let day = Day11(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay11_2() throws {
        let day = Day11(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
