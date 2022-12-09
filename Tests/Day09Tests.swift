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

    func testDay09_2a() throws {
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
        XCTAssertEqual(day.part2(), 1)
    }

    func testDay09_2b() throws {
        let day = Day09(rawInput: """
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
""")
        XCTAssertEqual(day.part2(), 36)
    }
}
