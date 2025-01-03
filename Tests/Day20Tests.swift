import XCTest
@testable import AdventOfCode

final class Day20Tests: XCTestCase {
    let input = """
1
2
-3
3
-2
0
4
"""

    func testDay20_1() throws {
        let day = Day20(input: input)
        XCTAssertEqual(day.part1(), 3)
    }

    func testDay20_2() throws {
        let day = Day20(input: input)
        XCTAssertEqual(day.part2(), 1623178306)
    }
}
