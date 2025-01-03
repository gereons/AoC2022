import XCTest
@testable import AdventOfCode

final class Day17Tests: XCTestCase {
    let input = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"

    func testDay17_1() throws {
        let day = Day17(input: input)
        XCTAssertEqual(day.part1(), 3068)
    }

    func testDay17_2() throws {
        let day = Day17(input: input)
        XCTAssertEqual(day.part2(), 1514285714288)
    }
}
