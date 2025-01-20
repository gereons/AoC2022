import Testing
@testable import AdventOfCode

@Suite struct Day20Tests {
    let input = """
1
2
-3
3
-2
0
4
"""

    @Test func testDay20_part1() throws {
        let day = Day20(input: input)
        #expect(day.part1() == 3)
    }

    @Test func testDay20_part2() throws {
        let day = Day20(input: input)
        #expect(day.part2() == 1623178306)
    }

    @Test func testDay20_part1_solution() {
        let day = Day20(input: Day20.input)
        #expect(day.part1() == 9945)
    }

    @Test func testDay20_part2_solution() {
        let day = Day20(input: Day20.input)
        #expect(day.part2() == 3338877775442)
    }
}
