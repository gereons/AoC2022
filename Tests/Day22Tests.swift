import XCTest
@testable import AdventOfCode

final class Day22Tests: XCTestCase {
    func testDay22_1() throws {
        let day = Day22(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }

    func testDay22_2() throws {
        let day = Day22(rawInput: "bar")
        XCTAssertEqual(day.part2(), 0)
    }
}
