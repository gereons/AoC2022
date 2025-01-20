import Testing
@testable import AdventOfCode

@Suite struct Day05Tests {
    @Test func testDay05_part1() throws {
        let day = Day05(input: """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
""")
        #expect(day.part1() == "CMZ")
    }

    @Test func testDay05_part2() throws {
        let day = Day05(input: """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
""")
        #expect(day.part2() == "MCD")
    }

    @Test func testDay05_part1_solution() {
        let day = Day05(input: Day05.input)
        #expect(day.part1() == "TLNGFGMFN")
    }

    @Test func testDay05_part2_solution() {
        let day = Day05(input: Day05.input)
        #expect(day.part2() == "FGLQJCMBD")
    }
}
