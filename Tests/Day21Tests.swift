import XCTest
@testable import AdventOfCode

final class Day21Tests: XCTestCase {
    func testDay21_1() throws {
        let day = Day21(rawInput: """
root: pppw + sjmn
dbpl: 5
cczh: sllz + lgvd
zczc: 2
ptdq: humn - dvpt
dvpt: 3
lfqf: 4
humn: 5
ljgn: 2
sjmn: drzm * dbpl
sllz: 4
pppw: cczh / lfqf
lgvd: ljgn * ptdq
drzm: hmdt - zczc
hmdt: 32
""")
        XCTAssertEqual(day.part1(), 152)
    }

//    func testDay21_2() throws {
//        let day = Day21(rawInput: """
//""")
//        XCTAssertEqual(day.part2(), 0)
//    }
}
