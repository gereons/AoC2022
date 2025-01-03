import XCTest
@testable import AdventOfCode

final class Day02Tests: XCTestCase {
    func testDay02_1() throws {
        let day = Day02(input: """
A Y
B X
C Z
""")
        XCTAssertEqual(day.part1(), 15)
    }

    func testDay02_2() throws {
        let day = Day02(input: """
A Y
B X
C Z
""")
        XCTAssertEqual(day.part2(), 12)
    }
}
