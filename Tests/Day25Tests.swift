import Testing
@testable import AdventOfCode

@Suite struct Day25Tests {
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

    @Test func testDay25_part1() throws {
        let day = Day25(input: input)
        #expect(day.part1() == "2=-1=0")
    }

    @Test func testDay25_part1_solution() {
        let day = Day25(input: Day25.input)
        #expect(day.part1() == "122-2=200-0111--=200")
    }
}
