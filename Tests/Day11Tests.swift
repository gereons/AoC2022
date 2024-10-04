import XCTest
@testable import AdventOfCode

@MainActor
final class Day11Tests: XCTestCase {
    func testDay11_1() throws {
        let day = Day11(input: input)
        XCTAssertEqual(day.part1(), 10605)
    }

    func testDay11_2() throws {
        let day = Day11(input: input)
        XCTAssertEqual(day.part2(), 2713310158)
    }

    let input = """
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
"""
}
