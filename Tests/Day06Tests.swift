import XCTest
@testable import AdventOfCode

final class Day06Tests: XCTestCase {
    func testDay06_1() throws {
        XCTAssertEqual(Day06(input: "mjqjpqmgbljsphdztnvjfqwrcgsmlb").part1(), 7)
        XCTAssertEqual(Day06(input: "bvwbjplbgvbhsrlpgdmjqwftvncz").part1(), 5)
        XCTAssertEqual(Day06(input: "nppdvjthqldpwncqszvftbrmjlhg").part1(), 6)
        XCTAssertEqual(Day06(input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").part1(), 10)
        XCTAssertEqual(Day06(input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").part1(), 11)
    }

    func testDay06_2() throws {
        XCTAssertEqual(Day06(input: "mjqjpqmgbljsphdztnvjfqwrcgsmlb").part2(), 19)
        XCTAssertEqual(Day06(input: "bvwbjplbgvbhsrlpgdmjqwftvncz").part2(), 23)
        XCTAssertEqual(Day06(input: "nppdvjthqldpwncqszvftbrmjlhg").part2(), 23)
        XCTAssertEqual(Day06(input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg").part2(), 29)
        XCTAssertEqual(Day06(input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw").part2(), 26)
    }
}
