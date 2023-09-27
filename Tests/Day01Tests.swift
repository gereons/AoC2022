import XCTest
@testable import AdventOfCode

final class Day01Tests: XCTestCase {
    func testDay01_1() throws {
        let day = Day01(input: """
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
""")
        XCTAssertEqual(day.part1(), 24000)
    }

    func testDay01_2() throws {
        let day = Day01(input: """
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
""")
        XCTAssertEqual(day.part2(), 45000)
    }
}
