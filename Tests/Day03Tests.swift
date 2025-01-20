import Testing
@testable import AdventOfCode

@Suite struct Day03Tests {
    @Test func testDay03_part1() throws {
        let day = Day03(input: """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
""")
        #expect(day.part1() == 157)
    }

    @Test func testDay03_part2() throws {
        let day = Day03(input: """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
""")
        #expect(day.part2() == 70)
    }

    @Test func testDay03_part1_solution() {
        let day = Day03(input: Day03.input)
        #expect(day.part1() == 8123)
    }

    @Test func testDay03_part2_solution() {
        let day = Day03(input: Day03.input)
        #expect(day.part2() == 2620)
    }
}
