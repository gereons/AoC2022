import XCTest
@testable import AdventOfCode

final class Day09Tests: XCTestCase {
    func testDay09_1() throws {
        let day = Day09(rawInput: """
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
""")
        XCTAssertEqual(day.part1(), 13)
    }

    func testDay09_2() throws {
        let day = Day09(rawInput: """
""")
        XCTAssertEqual(day.part2(), 0)
    }
}
