//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/16
//
// Partly based on
// https://todd.ginsberg.com/post/advent-of-code/2022/day16/
//

import AoCTools
import RegexBuilder
import Algorithms

private struct Valve {
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

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput

        valves = input.lines.map { Valve($0) }.mapped(by: \.id)
    }

    func part1() -> Int {
        let distances = computeDistances()
        let pressure = searchPaths(from: "AA", timeAllowed: 30, distances: distances)

        return pressure
    }

    func part2() -> Int {
        let distances = computeDistances()

        let valves = Set(distances.keys.filter { $0 != "AA" })
        var maxPressure = Int.min
        for halfOfValves in valves.combinations(ofCount: distances.count / 2) {
            let myPart = searchPaths(from: "AA", timeAllowed: 26, visited: Set(halfOfValves), distances: distances)
            let elephant = searchPaths(from: "AA", timeAllowed: 26, visited: valves - Set(halfOfValves), distances: distances)
            maxPressure = max(maxPressure, myPart + elephant)
        }

        return maxPressure
    }

    private func searchPaths(from valve: String,
                             timeAllowed: Int,
                             visited: Set<String> = [],
                             distances: [String: [String: Int]],
                             timeTaken: Int = 0,
                             totalFlow: Int = 0
    ) -> Int {
        let next = distances[valve]!
            .map { ($0, $1) }
            .filter { valve, _ in !visited.contains(valve) }
            .filter { _, distance in timeTaken + distance + 1 < timeAllowed }

        var maxFlow = Int.min
        for (nextValve, distance) in next {
            let flow = searchPaths(from: nextValve,
                                   timeAllowed: timeAllowed,
                                   visited: visited + nextValve,
                                   distances: distances,
                                   timeTaken: timeTaken + distance + 1,
                                   totalFlow: totalFlow + ((timeAllowed - timeTaken - distance - 1) * valves[nextValve]!.flowRate)
            )
            maxFlow = max(maxFlow, flow)
        }

        return maxFlow != Int.min ? maxFlow : totalFlow
    }

    private func computeDistances() -> [String: [String: Int]] {
        let interestingValves = valves.values
            .filter { $0.id == "AA" || $0.flowRate > 0 }
            .map { $0.id }

        let result = interestingValves.map { valve in
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
            distances = distances.filter { valves[$0.key]!.flowRate > 0 }
            return (valve, distances)
        }
        return Dictionary(uniqueKeysWithValues: result)
    }
}
