import XCTest
@testable import AdventOfCode

final class Day18Tests: XCTestCase {
    let input = """
2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5
"""

    func testDay18_1() throws {
        let day = Day18(input: input)
        XCTAssertEqual(day.part1(), 64)
    }

    func testDay18_2() throws {
        let day = Day18(input: input)
        XCTAssertEqual(day.part2(), 58)
    }
}
