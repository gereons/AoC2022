//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/16
//

import AoCTools
import RegexBuilder

private struct Valve: Equatable {
    let id: String
    let flowRate: Int
    let leadsTo: [String]

    init(_ str: String) {
        // Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
        // Valve AA has flow rate=0; tunnel leads to valve DD
        let regex = Regex {
            "Valve "
            Capture(ZeroOrMore(.word)) { String($0) }
            " has flow rate="
            Capture(ZeroOrMore(.digit)) { Int($0)! }
            ChoiceOf {
                "; tunnels lead to valves "
                "; tunnel leads to valve "
            }
            Capture(ZeroOrMore(.any)) { String($0) }
        }

        let matches = try! regex.wholeMatch(in: str)!.output
        id = matches.1
        flowRate = matches.2
        leadsTo = matches.3.components(separatedBy: ", ")
    }
}

final class Day16: AOCDay {
    private let valves: [String: Valve]
    private let maxOpen: Int

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput

        valves = input.lines.map { Valve($0) }.mapped(by: \.id)
        maxOpen = valves.values.count { $0.flowRate > 0 }
    }

    func part1() -> Int {
        let aa = valves["AA"]!

        return openValves(startAt: aa)
    }

    func part2() -> Int {
        return 0
    }

    private func openValves(startAt: Valve) -> Int {
        var results = [[Open]]()

        openValves(startAt: startAt, minute: 1, open: [], results: &results)

        var maxPressure = Int.min
        var maxResult = [Open]()
        for result in results {
            var pressure = 0
            for op in result {
                pressure += op.flowRate * (30 - op.minute)
            }
            // maxPressure = max(maxPressure, pressure)
            if pressure > maxPressure {
                maxPressure = pressure
                maxResult = result
            }
        }

        return maxPressure
    }

    private struct Open: Hashable {
        let valve: String
        let flowRate: Int
        let minute: Int
    }

    private struct State: Hashable {
        let openValves: [Open]
        let current: String
        let next: String
    }

    private var seen = Set<State>()

    private func openValves(startAt valve: Valve, minute: Int, open: [Open], results: inout [[Open]]) {
        if minute > 30 || open.count == maxOpen {
            results.append(open)
            return
        }

        var open = open
        var minute = minute
        if valve.flowRate > 0 {
            let isOpen = open.contains { $0.valve == valve.id }
            if !isOpen {
                minute += 1
                open.append(Open(valve: valve.id, flowRate: valve.flowRate, minute: minute))
            }
        }

        for goto in valve.leadsTo {
            let target = valves[goto]!
            let state = State(openValves: open, current: valve.id, next: target.id)
            if !seen.contains(state) {
                seen.insert(state)
                openValves(startAt: target, minute: minute + 1, open: open, results: &results)
            }
        }
    }
}
