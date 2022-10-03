import XCTest
@testable import AdventOfCode

final class Day01Tests: XCTestCase {
    func testDay01_1() throws {
        let day = Day01(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay01_2() throws {
        let day = Day01(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
