import Testing
@testable import AdventOfCode

@Suite struct Day08Tests {
    let input = """
30373
25512
65332
33549
35390
"""

    @Test func testDay08_part1() throws {
        let day = Day08(input: input)
        #expect(day.part1() == 21)
    }

    @Test func testDay08_part2() throws {
        let day = Day08(input: input)
        #expect(day.part2() == 8)
    }

    @Test func testDay08_part1_solution() {
        let day = Day08(input: Day08.input)
        #expect(day.part1() == 1785)
    }

    @Test func testDay08_part2_solution() {
        let day = Day08(input: Day08.input)
        #expect(day.part2() == 345168)
    }
}
