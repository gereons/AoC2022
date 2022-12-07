import XCTest
@testable import AdventOfCode

final class Day07Tests: XCTestCase {
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

    func testDay07_1() throws {
        let day = Day07(rawInput: input)
        XCTAssertEqual(day.part1(), 95437)
    }

    func testDay07_2() throws {
        let day = Day07(rawInput: input)
        XCTAssertEqual(day.part2(), 24933642)
    }
}
