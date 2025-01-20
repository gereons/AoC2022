import Testing
@testable import AdventOfCode

@Suite struct Day14Tests {
    @Test func testDay14_part1() throws {
        let day = Day14(input: """
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
""")
        #expect(day.part1() == 24)
    }

    @Test func testDay14_part2() throws {
        let day = Day14(input: """
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9
""")
        #expect(day.part2() == 93)
    }

    @Test func testDay14_part1_solution() {
        let day = Day14(input: Day14.input)
        #expect(day.part1() == 1133)
    }

    @Test func testDay14_part2_solution() {
        let day = Day14(input: Day14.input)
        #expect(day.part2() == 27566)
    }
}
