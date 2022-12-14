import XCTest
@testable import AdventOfCode

final class Day13Tests: XCTestCase {
    let input = """
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
"""

    func testDay13_1() throws {
        let day = Day13(rawInput: input)
        XCTAssertEqual(day.part1(), 13)
    }

    func testDay13_2() throws {
        let day = Day13(rawInput: input)
        XCTAssertEqual(day.part2(), 140)
    }
}
