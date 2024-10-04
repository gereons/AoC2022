import XCTest
@testable import AdventOfCode

@MainActor
final class Day04Tests: XCTestCase {
    func testDay04_1() throws {
        let day = Day04(input: """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
""")
        XCTAssertEqual(day.part1(), 2)
    }

    func testDay04_2() throws {
        let day = Day04(input: """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
""")
        XCTAssertEqual(day.part2(), 4)
    }
}
