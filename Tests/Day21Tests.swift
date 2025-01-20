import Testing
@testable import AdventOfCode

@Suite struct Day21Tests {
    let input = """
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
"""

    @Test func testDay21_part1() throws {
        let day = Day21(input: input)
        #expect(day.part1() == 152)
    }

    @Test func testDay21_part2() throws {
        let day = Day21(input: input)
        #expect(day.part2() == 301)
    }

    @Test func testDay21_part1_solution() {
        let day = Day21(input: Day21.input)
        #expect(day.part1() == 291425799367130)
    }

    @Test func testDay21_part2_solution() {
        let day = Day21(input: Day21.input)
        #expect(day.part2() == 3219579395609)
    }
}
