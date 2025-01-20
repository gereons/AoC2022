import Testing
@testable import AdventOfCode

@Suite struct Day01Tests {
    @Test func testDay01_part1() throws {
        let day = Day01(input: """
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
""")
        #expect(day.part1() == 24000)
    }

    @Test func testDay01_part2() throws {
        let day = Day01(input: """
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
""")
        #expect(day.part2() == 45000)
    }

    @Test func testDay01_part1_solution() {
        let day = Day01(input: Day01.input)
        #expect(day.part1() == 69912)
    }

    @Test func testDay01_part2_solution() {
        let day = Day01(input: Day01.input)
        #expect(day.part2() == 208180)
    }
}
