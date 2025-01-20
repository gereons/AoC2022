import Testing
@testable import AdventOfCode

@Suite struct Day09Tests {
    @Test func testDay09_part1() throws {
        var day = Day09(input: """
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
""")
        #expect(day.part1() == 13)

        day = Day09(input: """
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
""")
        #expect(day.part2() == 1)

        day = Day09(input: """
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
""")
        #expect(day.part2() == 36)
    }

    @Test func testDay09_part1_solution() {
        let day = Day09(input: Day09.input)
        #expect(day.part1() == 6284)
    }

    @Test func testDay09_part2_solution() {
        let day = Day09(input: Day09.input)
        #expect(day.part2() == 2661)
    }
}
