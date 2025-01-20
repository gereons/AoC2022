import Testing
@testable import AdventOfCode

@Suite struct Day04Tests {
    @Test func testDay04_part1() throws {
        let day = Day04(input: """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
""")
        #expect(day.part1() == 2)
    }

    @Test func testDay04_part2() throws {
        let day = Day04(input: """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
""")
        #expect(day.part2() == 4)
    }

    @Test func testDay04_part1_solution() {
        let day = Day04(input: Day04.input)
        #expect(day.part1() == 459)
    }

    @Test func testDay04_part2_solution() {
        let day = Day04(input: Day04.input)
        #expect(day.part2() == 779)
    }
}
