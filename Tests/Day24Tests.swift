import XCTest
@testable import AdventOfCode

final class Day24Tests: XCTestCase {
    let input = """
        #.######
        #>>.<^<#
        #.<..<<#
        #>v.><>#
        #<^v^^>#
        ######.#
        """

    func testDay24_1() throws {
        let day = Day24(input: input)
        XCTAssertEqual(day.part1(), 18)
    }

    func testDay24_2() throws {
        let day = Day24(input: input)
        XCTAssertEqual(day.part2(), 54)
    }
}
