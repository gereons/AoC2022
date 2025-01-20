import Testing
@testable import AdventOfCode

@Suite struct Day02Tests {
    @Test func testDay02_part1() throws {
        let day = Day02(input: """
A Y
B X
C Z
""")
        #expect(day.part1() == 15)
    }

    @Test func testDay02_part2() throws {
        let day = Day02(input: """
A Y
B X
C Z
""")
        #expect(day.part2() == 12)
    }

    @Test func testDay02_part1_solution() {
        let day = Day02(input: Day02.input)
        #expect(day.part1() == 12535)
    }

    @Test func testDay02_part2_solution() {
        let day = Day02(input: Day02.input)
        #expect(day.part2() == 15457)
    }
}
