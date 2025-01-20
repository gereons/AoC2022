import Testing
import AoCTools
@testable import AdventOfCode

@Suite struct Day22Tests {
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

    @Test func testDay22_part1() throws {
        let day = Day22(input: input)
        #expect(day.part1() == 6032)
    }


    @Test func testDay22_part2() throws {
        let day = Day22(input: input)
        let result = day.part2()
        #expect(result == 5031)
    }

    @Test func testDay22_part1_solution() {
        let day = Day22(input: Day22.input)
        #expect(day.part1() == 97356)
    }

    @Test func testDay22_part2_solution() {
        let day = Day22(input: Day22.input)
        #expect(day.part2() == 120175)
    }
}
