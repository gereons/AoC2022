//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/6
//

import AoCTools

final class Day06: AOCDay {
    let chars: [Character]
    
    init(input: String? = nil) {
        let input = input ?? Self.input
        chars = Array(input)
    }

    func part1() -> Int {
        findMarker(length: 4)
    }

    func part2() -> Int {
        findMarker(length: 14)
    }

    private func findMarker(length: Int) -> Int {
        for i in 0 ..< (chars.count - length) {
            let marker = chars[i ..< i + length]
            if Set(marker).count == length {
                return i + length
            }
        }
        return -1
    }
}
