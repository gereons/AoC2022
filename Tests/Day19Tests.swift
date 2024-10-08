import XCTest
@testable import AdventOfCode

@MainActor
final class Day19Tests: XCTestCase {
    let input = """
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.
"""

    func testDay19_1() throws {
        let day = Day19(input: input)
        XCTAssertEqual(day.part1(), 33)
    }

    func testDay19_2() throws {
        let day = Day19(input: input)
        XCTAssertEqual(day.part2(), 3472)
    }
}
