import XCTest
@testable import AdventOfCode

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
        let day = Day22(rawInput: input)
        XCTAssertEqual(day.part1(), 6032)
    }

    func testDay22_2() throws {
        let day = Day22(rawInput: input)
        XCTAssertEqual(day.part2(), 5031)
    }
}
