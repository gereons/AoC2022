import Testing
@testable import AdventOfCode

@Suite struct Day07Tests {
    let input = """
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
"""

    @Test func testDay07_part1() throws {
        let day = Day07(input: input)
        #expect(day.part1() == 95437)
    }

    @Test func testDay07_part2() throws {
        let day = Day07(input: input)
        #expect(day.part2() == 24933642)
    }

    @Test func testDay07_part1_solution() {
        let day = Day07(input: Day07.input)
        #expect(day.part1() == 1367870)
    }

    @Test func testDay07_part2_solution() {
        let day = Day07(input: Day07.input)
        #expect(day.part2() == 549173)
    }
}
