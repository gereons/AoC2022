import Testing
@testable import AdventOfCode

@Suite struct Day12Tests {
    @Test func testDay12_part1() throws {
        let day = Day12(input: """
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
""")
        #expect(day.part1() == 31)
    }

    @Test func testDay12_part2() throws {
        let day = Day12(input: """
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
""")
        #expect(day.part2() == 29)
    }

    @Test func testDay12_part1_solution() {
        let day = Day12(input: Day12.input)
        #expect(day.part1() == 472)
    }

    @Test func testDay12_part2_solution() {
        let day = Day12(input: Day12.input)
        #expect(day.part2() == 465)
    }
}
