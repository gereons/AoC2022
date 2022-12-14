import XCTest
@testable import AdventOfCode

final class Day13Tests: XCTestCase {
    let input = """
[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]
"""

    func testDay13_parse() throws {
//        typealias List = Day13.List
//        typealias Parser = Day13.Parser
//        XCTAssertEqual(Parser.createList(from: "[1,1,3,1,1]"), List(integers: [1,1,3,1,1]))
//        XCTAssertEqual(Parser.createList(from: "[1,1,5,1,1]"), List(integers: [1,1,5,1,1]))
//        XCTAssertEqual(Parser.createList(from: "[[1],[2,3,4]]"), List(lists: [List(integers: [1]), List(integers: [2,3,4])]))
//        XCTAssertEqual(Parser.createList(from: "[[1],4]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[9]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[[8,7,6]]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[[4,4],4,4]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[[4,4],4,4,4]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[7,7,7,7]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[7,7,7]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[3]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[[[]]]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[[]]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[1,[2,[3,[4,[5,6,7]]]],8,9]"), foo)
//        XCTAssertEqual(Parser.createList(from: "[1,[2,[3,[4,[5,6,0]]]],8,9]"), foo)
    }

    func testDay13_1() throws {
        let day = Day13(rawInput: input)
        XCTAssertEqual(day.part1(), 13)
    }

    func testDay13_2() throws {
        let day = Day13(rawInput: """
""")
        XCTAssertEqual(day.part2(), 0)
    }
}
