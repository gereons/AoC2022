//
// Advent of Code 2022
//

import AoCTools

@main
struct AdventOfCode {
    enum Day {
        case all
        case day(Int)
    }

    static func main() {
        run(.all)
        Timer.showTotal()
    }

    private static func run(_ day: Day) {
        switch day {
        case .all:
            days.forEach { day in
                day.init(rawInput: nil).run()
            }
        case .day(let day):
            days[day-1].init(rawInput: nil).run()
        }
    }

    private static let days: [Runnable.Type] = [
        Day01.self, Day02.self, Day03.self, Day04.self, Day05.self,
        Day06.self, Day07.self, Day08.self, Day09.self, Day10.self,
        Day11.self, Day12.self, Day13.self, Day14.self, Day15.self,
        Day16.self, Day17.self, Day18.self, Day19.self, Day20.self,
        Day21.self, Day22.self, Day23.self, Day24.self, Day25.self
    ]
}
