import XCTest
@testable import AdventOfCode

final class Day05Tests: XCTestCase {
    func testDay05_1() throws {
        let day = Day05(rawInput: """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
""")
        XCTAssertEqual(day.part1(), "CMZ")
    }

    func testDay05_2() throws {
        let day = Day05(rawInput: """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
""")
        XCTAssertEqual(day.part2(), "MCD")
    }
}
