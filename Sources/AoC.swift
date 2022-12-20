//
// Advent of Code 2022
//

import AoCTools
import Foundation

@main
struct AdventOfCode {
    // assign to eg `.day(5)`, leave as nil to run the puzzle for the current calendar day
    static var defaultDay: Day? // = .day(1)

    static func main() {
        var day = defaultDay ?? today

        if CommandLine.argc > 1 {
            let arg = CommandLine.arguments[1]
            if let d = Int(arg), 1...25 ~= d {
                day = .day(d)
            } else if arg == "all" {
                day = .all
            }
        }
        
        run(day)
        Timer.showTotal()
    }

    static var today: Day {
        let components = Calendar.current.dateComponents([.day, .month], from: Date())
        let day = components.day!
        if components.month == 12 && 1...25 ~= day {
            return .day(day)
        }
        return .all
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

    enum Day {
        case all
        case day(Int)
    }

    private static let days: [Runnable.Type] = [
        Day01.self, Day02.self, Day03.self, Day04.self, Day05.self,
        Day06.self, Day07.self, Day08.self, Day09.self, Day10.self,
        Day11.self, Day12.self, Day13.self, Day14.self, Day15.self,
        Day16.self, Day17.self, Day18.self, Day19.self, Day20.self,
        Day21.self, Day22.self, Day23.self, Day24.self, Day25.self
    ]
}
