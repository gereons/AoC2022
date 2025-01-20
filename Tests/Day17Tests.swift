import Testing
@testable import AdventOfCode

@Suite struct Day17Tests {
    let input = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"

    @Test func testDay17_part1() throws {
        let day = Day17(input: input)
        #expect(day.part1() == 3068)
    }

    @Test func testDay17_part2() throws {
        let day = Day17(input: input)
        #expect(day.part2() == 1514285714288)
    }

    @Test func testDay17_part1_solution() {
        let day = Day17(input: Day17.input)
        #expect(day.part1() == 3141)
    }

    @Test func testDay17_part2_solution() {
        let day = Day17(input: Day17.input)
        #expect(day.part2() == 1561739130391)
    }
}
