import Testing
@testable import AdventOfCode

@Suite struct Day18Tests {
    let input = """
2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5
"""

    @Test func testDay18_part1() throws {
        let day = Day18(input: input)
        #expect(day.part1() == 64)
    }

    @Test func testDay18_part2() throws {
        let day = Day18(input: input)
        #expect(day.part2() == 58)
    }

    @Test func testDay18_part1_solution() {
        let day = Day18(input: Day18.input)
        #expect(day.part1() == 4444)
    }

    @Test func testDay18_part2_solution() {
        let day = Day18(input: Day18.input)
        #expect(day.part2() == 2530)
    }
}
