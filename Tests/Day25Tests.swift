import XCTest
@testable import AdventOfCode

final class Day25Tests: XCTestCase {
    let input = """
        1=-0-2
        12111
        2=0=
        21
        2=01
        111
        20012
        112
        1=-1=
        1-12
        12
        1=
        122
        """

    func testDay25_1() throws {
        let day = Day25(rawInput: input)
        XCTAssertEqual(day.part1(), "2=-1=0")
    }
}
