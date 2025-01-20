import Testing
@testable import AdventOfCode

@Suite struct Day15Tests {
    let input = """
Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3
"""

    @Test func testDay15_part1() throws {
        let day = Day15(input: input, row: 10, size: 20)
        #expect(day.part1() == 26)
    }

    @Test func testDay15_part2() throws {
        let day = Day15(input: input, row: 10, size: 20)
        #expect(day.part2() == 56000011)
    }

    @Test func testDay15_part1_solution() {
        let day = Day15(input: Day15.input)
        #expect(day.part1() == 4827924)
    }

    @Test func testDay15_part2_solution() {
        let day = Day15(input: Day15.input)
        #expect(day.part2() == 12977110973564)
    }
}
