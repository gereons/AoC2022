import XCTest
@testable import AdventOfCode

final class Day08Tests: XCTestCase {
    let input = """
30373
25512
65332
33549
35390
"""

    func testDay08_1() throws {
        let day = Day08(rawInput: input)
        XCTAssertEqual(day.part1(), 21)
    }

    func testDay08_2() throws {
        let day = Day08(rawInput: input)
        XCTAssertEqual(day.part2(), 8)
    }
}
