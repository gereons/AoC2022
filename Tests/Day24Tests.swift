import Testing
@testable import AdventOfCode

@Suite struct Day24Tests {
    let input = """
        #.######
        #>>.<^<#
        #.<..<<#
        #>v.><>#
        #<^v^^>#
        ######.#
        """

    @Test func testDay24_part1() throws {
        let day = Day24(input: input)
        #expect(day.part1() == 18)
    }

    @Test func testDay24_part2() throws {
        let day = Day24(input: input)
        #expect(day.part2() == 54)
    }

    @Test func testDay24_part1_solution() {
        let day = Day24(input: Day24.input)
        #expect(day.part1() == 255)
    }

    @Test func testDay24_part2_solution() {
        let day = Day24(input: Day24.input)
        #expect(day.part2() == 809)
    }
}
