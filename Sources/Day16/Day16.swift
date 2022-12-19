//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/16
//

import AoCTools
import RegexBuilder

private struct Valve: Equatable, Hashable {
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

private struct Step: Hashable {
    let valve: Valve
    let openedAt: Int
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
        let results = openAllValves(startAt: aa)

        var maxPressure = 0
        for result in results {
            var pressure = 0
            for step in result {
                pressure += step.valve.flowRate * (30 - step.openedAt)
            }
            maxPressure = max(maxPressure, pressure)
        }

        return maxPressure
    }

    private func openAllValves(startAt valve: Valve) -> [[Step]] {
        var result = [[Step]]()
        let remaining = valves.values.filter { $0.flowRate > 0 }
        let distances = computeDistances()

        openRemainingValves(startAt: valve,
                            minute: 1,
                            remaining: Set(remaining),
                            stepsSoFar: [],
                            distances: distances,
                            result: &result)
        return result
    }

    private func openRemainingValves(startAt valve: Valve,
                                     minute: Int,
                                     remaining: Set<Valve>,
                                     stepsSoFar: [Step],
                                     distances: [String: [String: Int]],
                                     result: inout [[Step]]
    ) {
        if remaining.isEmpty || minute >= 30 {
            result.append(stepsSoFar)
            return
        }

        for nextToOpen in remaining {
            let distance = distances[valve.id]![nextToOpen.id]!
            let step = Step(valve: nextToOpen, openedAt: minute + distance)
            openRemainingValves(startAt: nextToOpen,
                                minute: minute + distance + 1,
                                remaining: remaining.subtracting([nextToOpen]),
                                stepsSoFar: stepsSoFar + [step],
                                distances: distances,
                                result: &result)
        }
    }

    func part2() -> Int {
        return 0
    }

    private func computeDistances() -> [String: [String: Int]] {
        let result = valves.keys.map { valve in
            var distances = [valve: 0]
            var queue = [valve]
            while !queue.isEmpty {
                let current = queue.removeFirst()
                for next in valves[current]!.leadsTo {
                    let newDistance = distances[current]! + 1
                    if newDistance < distances[next, default: Int.max] {
                        distances[next] = newDistance
                        queue.append(next)
                    }
                }
            }
            return (valve, distances)
        }
        return Dictionary(uniqueKeysWithValues: result)
    }
}
