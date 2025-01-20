import Testing
@testable import AdventOfCode

@Suite struct Day13Tests {
    let input = """
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
"""

    @Test func testDay13_part1() throws {
        let day = Day13(input: input)
        #expect(day.part1() == 13)
    }

    @Test func testDay13_part2() throws {
        let day = Day13(input: input)
        #expect(day.part2() == 140)
    }

    @Test func testDay13_part1_solution() {
        let day = Day13(input: Day13.input)
        #expect(day.part1() == 4894)
    }

    @Test func testDay13_part2_solution() {
        let day = Day13(input: Day13.input)
        #expect(day.part2() == 24180)
    }
}
