import XCTest
@testable import AdventOfCode

final class Day25Tests: XCTestCase {
    func testDay25_1() throws {
        let day = Day25(rawInput: "foo")
        XCTAssertEqual(day.part1(), 0)
    }
}
