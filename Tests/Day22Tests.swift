import XCTest
import AoCTools
@testable import AdventOfCode

@MainActor
final class Day22Tests: XCTestCase {
    let input = """
        ...#
        .#..
        #...
        ....
...#.......#
........#...
..#....#....
..........#.
        ...#....
        .....#..
        .#......
        ......#.

10R5L5R10L4R5L5
"""

    func testDay22_1() throws {
        let day = Day22(input: input)
        XCTAssertEqual(day.part1(), 6032)
    }


    func testDay22_2() throws {
        let day = Day22(input: input)
        let result = day.part2()
        XCTAssertEqual(result, 5031)
    }
}
