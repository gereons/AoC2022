//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/3
//

import AoCTools

final class Day03: AOCDay {
    let rucksacks: [String]

    init(input: String? = nil) {
        let input = input ?? Self.input
        rucksacks = input.lines
    }

    func part1() -> Int {
        var prio = 0
        for rucksack in rucksacks {
            let set1 = Set(rucksack.prefix(rucksack.count / 2).map { $0 })
            let set2 = Set(rucksack.suffix(rucksack.count / 2).map { $0 })

            let common = set1.intersection(set2)
            prio += priority(for: common.first!)
        }

        return prio
    }

    func part2() -> Int {
        var prio = 0
        for group in rucksacks.chunked(3) {
            let sets = group.map { Set($0.map { $0 }) }
            let common = sets[0].intersection(sets[1]).intersection(sets[2])
            prio += priority(for: common.first!)
        }
        return prio
    }

    private func priority(for ch: Character) -> Int {
        let ascii = Int(ch.asciiValue!)
        if ascii >= 97 {
            return ascii - 96
        } else if ascii >= 64 {
            return ascii - 38
        } else {
            fatalError()
        }
    }
}
