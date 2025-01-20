import Testing
@testable import AdventOfCode

@Suite struct Day19Tests {
    let input = """
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
"""

    @Test func testDay19_part1() throws {
        let day = Day19(input: input)
        #expect(day.part1() == 33)
    }

    @Test func testDay19_part2() throws {
        let day = Day19(input: input)
        #expect(day.part2() == 3472)
    }

    @Test func testDay19_part1_solution() {
        let day = Day19(input: Day19.input)
        #expect(day.part1() == 1659)
    }

    @Test func testDay19_part2_solution() {
        let day = Day19(input: Day19.input)
        #expect(day.part2() == 6804)
    }
}
