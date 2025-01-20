import Testing
@testable import AdventOfCode

@Suite struct Day06Tests {
    @Test func testDay06_part1() throws {
        #expect(Day06(input: "mjqjpqmgbljsphdztnvjfqwrcgsmlb").part1() == 7)
        #expect(Day06(input: "bvwbjplbgvbhsrlpgdmjqwftvncz").part1() == 5)
        #expect(Day06(input: "nppdvjthqldpwncqszvftbrmjlhg").part1() == 6)
        #expect(Day06(input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").part1() == 10)
        #expect(Day06(input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").part1() == 11)
    }

    @Test func testDay06_part2() throws {
        #expect(Day06(input: "mjqjpqmgbljsphdztnvjfqwrcgsmlb").part2() == 19)
        #expect(Day06(input: "bvwbjplbgvbhsrlpgdmjqwftvncz").part2() == 23)
        #expect(Day06(input: "nppdvjthqldpwncqszvftbrmjlhg").part2() == 23)
        #expect(Day06(input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").part2() == 29)
        #expect(Day06(input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").part2() == 26)
    }

    @Test func testDay06_part1_solution() {
        let day = Day06(input: Day06.input)
        #expect(day.part1() == 1892)
    }

    @Test func testDay06_part2_solution() {
        let day = Day06(input: Day06.input)
        #expect(day.part2() == 2313)
    }
}
