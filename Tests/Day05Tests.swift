import XCTest
@testable import AdventOfCode

final class Day05Tests: XCTestCase {
    func testDay05_1() throws {
        let day = Day05(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay05_2() throws {
        let day = Day05(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
