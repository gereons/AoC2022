import XCTest
@testable import AdventOfCode

final class Day04Tests: XCTestCase {
    func testDay04_1() throws {
        let day = Day04(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay04_2() throws {
        let day = Day04(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
