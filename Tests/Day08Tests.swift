import XCTest
@testable import AdventOfCode

final class Day08Tests: XCTestCase {
    func testDay08_1() throws {
        let day = Day08(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay08_2() throws {
        let day = Day08(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
