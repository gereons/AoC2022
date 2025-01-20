import Testing
@testable import AdventOfCode

@Suite struct Day23Tests {
    let smallInput = """
    .....
    ..##.
    ..#..
    .....
    ..##.
    .....
    """

    let input = """
        ..............
        ..............
        .......#......
        .....###.#....
        ...#...#.#....
        ....#...##....
        ...#.###......
        ...##.#.##....
        ....#..#......
        ..............
        ..............
        ..............
        """
    @Test func testDay23_part1() throws {
        var day = Day23(input: smallInput)
        #expect(day.part1() == 25)

        day = Day23(input: input)
        #expect(day.part1() == 110)
    }

    @Test func testDay23_part2() throws {
        let day = Day23(input: input)
        #expect(day.part2() == 20)
    }

    @Test func testDay23_part1_solution() {
        let day = Day23(input: Day23.input)
        #expect(day.part1() == 4218)
    }

    @Test func testDay23_part2_solution() {
        let day = Day23(input: Day23.input)
        #expect(day.part2() == 976)
    }
}
