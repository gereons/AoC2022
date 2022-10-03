import XCTest
@testable import AdventOfCode

final class Day02Tests: XCTestCase {
    func testDay02_1() throws {
        let day = Day02(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay02_2() throws {
        let day = Day02(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
