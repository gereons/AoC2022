import XCTest
@testable import AdventOfCode

final class Day06Tests: XCTestCase {
    func testDay06_1() throws {
        XCTAssertEqual(Day06(rawInput: "mjqjpqmgbljsphdztnvjfqwrcgsmlb").part1(), 7)
        XCTAssertEqual(Day06(rawInput: "bvwbjplbgvbhsrlpgdmjqwftvncz").part1(), 5)
        XCTAssertEqual(Day06(rawInput: "nppdvjthqldpwncqszvftbrmjlhg").part1(), 6)
        XCTAssertEqual(Day06(rawInput: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").part1(), 10)
        XCTAssertEqual(Day06(rawInput: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").part1(), 11)
    }

    func testDay06_2() throws {
        XCTAssertEqual(Day06(rawInput: "mjqjpqmgbljsphdztnvjfqwrcgsmlb").part2(), 19)
        XCTAssertEqual(Day06(rawInput: "bvwbjplbgvbhsrlpgdmjqwftvncz").part2(), 23)
        XCTAssertEqual(Day06(rawInput: "nppdvjthqldpwncqszvftbrmjlhg").part2(), 23)
        XCTAssertEqual(Day06(rawInput: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").part2(), 29)
        XCTAssertEqual(Day06(rawInput: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").part2(), 26)
    }
}
