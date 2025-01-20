import Testing
@testable import AdventOfCode

@Suite struct Day16Tests {
    let input = """
Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II
"""

    @Test func testDay16_part1() throws {
        let day = Day16(input: input)
        #expect(day.part1() == 1651)
    }

    @Test func testDay16_part2() throws {
        let day = Day16(input: input)
        #expect(day.part2() == 1707)
    }

    @Test func testDay16_part1_solution() {
        let day = Day16(input: Day16.input)
        #expect(day.part1() == 1915)
    }

    @Test func testDay16_part2_solution() {
        let day = Day16(input: Day16.input)
        #expect(day.part2() == 2772)
    }
}
