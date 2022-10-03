import XCTest
@testable import AdventOfCode

final class Day03Tests: XCTestCase {
    func testDay03_1() throws {
        let day = Day03(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay03_2() throws {
        let day = Day03(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
