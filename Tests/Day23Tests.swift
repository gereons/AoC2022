import XCTest
@testable import AdventOfCode

final class Day23Tests: XCTestCase {
    func testDay23_1() throws {
        let day = Day23(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay23_2() throws {
        let day = Day23(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
