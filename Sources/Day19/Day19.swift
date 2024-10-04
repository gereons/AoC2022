//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/19
//

// After many false starts and trying solutions from reddit that didn't even pass the unit tests for part 2,
// let alone provide correct answers for my input, I gave up.
//
// this here is based on
// https://github.com/SwampThingTom/AoC2022/tree/main/19-NotEnoughMinerals
// with only some minor touchups (no more stringified APIs, for example)

import AoCTools

private enum Resource: CaseIterable {
    case ore
    case clay
    case obsidian
    case geode
}

// An array of tuples where the first element is an amount and the second is a resource.
private typealias Costs = [(Int, Resource)]

// The resource costs for a robot that collects a particular resource.
private struct Robot {
    let collects: Resource
    let costs: Costs
}

// Represents a factory that is capable of building robots that collect resources.
private struct Factory {
    let blueprint: [Resource: Costs]
    private var robots: [Resource: Int] = [:]
    private var resources: [Resource: Int] = [:]

    let maxMinutes: Int
    private var minute = 1

    var isFinished: Bool { minute > maxMinutes }
    var geodes: Int { resources[.geode, default: 0] }

    init(_ blueprint: [Robot], minutesToRun: Int) {
        self.blueprint = Dictionary(uniqueKeysWithValues: blueprint.map { ($0.collects, $0.costs) })
        self.robots[.ore] = 1
        self.maxMinutes = minutesToRun
    }

    // Returns a new factory that represents the state after building the requested robot.
    // The caller must first have verified that the robot can be built by calling `canBuild()`.
    private func factory(afterBuilding newRobot: Resource) -> Factory {
        assert(minute <= maxMinutes)
        var newFactory = self
        var robotBuilt = false
        while !newFactory.isFinished && !robotBuilt {
            robotBuilt = newFactory.runOneMinute(building: newRobot)
        }
        return newFactory
    }

    // Runs the factory for one minute, building the given robot if possible.
    // Returns true if the robot was built.
    private mutating func runOneMinute(building robot: Resource) -> Bool {
        var didBuildRobot = false
        // debugPrint("== Minute \(minute) ==")

        if canBuildNow(robot) {
            startBuilding(robot)
            didBuildRobot = true
        }

        collectResources()

        if didBuildRobot {
            build(robot)
        }

        minute += 1
        return didBuildRobot
    }

    // Returns true if we have robots available that can collect the resources
    // needed to build the given robot.
    private func canBuild(_ robot: Resource) -> Bool {
        blueprint[robot]!.allSatisfy { robots[$0.1, default: 0] > 0 }
    }

    // Returns true if we have the resources to build a robot of the given type.
    private func canBuildNow(_ robot: Resource) -> Bool {
        blueprint[robot]!.allSatisfy { resources[$0.1, default: 0] >= $0.0 }
    }

    // Heuristic to determine whether a robot is worth building came from this reddit post.
    // https://www.reddit.com/r/adventofcode/comments/zpy5rm/2022_day_19_what_are_your_insights_and/
    private func shouldBuild(_ robot: Resource) -> Bool {
        if robot == .geode {
            return true
        }

        let numRobots = robots[robot, default: 0]
        let numResource = resources[robot, default: 0]
        let minutesRemaining = maxMinutes - minute + 1
        let maxNeeded = maxNeeded(resource: robot)
        return numRobots * minutesRemaining + numResource < minutesRemaining * maxNeeded
    }

    // Returns the maximum amount of the given resource required to build any robot.
    private func maxNeeded(resource: Resource) -> Int {
        blueprint.values.compactMap { costs in
            costs.first { $0.1 == resource }?.0
        }.max()!
    }

    // Deducts the resources used to build the given robot (but does not yet add the robot to the factory).
    private mutating func startBuilding(_ robot: Resource) {
        // debugPrint("Spend \(blueprint[robot]!) to start building a \(robot)-collecting robot.")
        blueprint[robot]!.forEach { cost in
            resources[cost.1, default: 0] -= cost.0
            assert(resources[cost.1]!>=0)
        }
    }

    // Adds a robot of the given type to the factory.
    private mutating func build(_ robot: Resource) {
        robots[robot, default: 0] += 1
        // debugPrint("The new \(robot)-collecting robot is now ready; you now have \(robots[robot]!) of them.")
    }

    // Adds the resources collected by all robots in the factory for one minute.
    private mutating func collectResources() {
        robots.forEach { resource, numRobots in
            guard numRobots > 0 else { return }
            resources[resource, default: 0] += numRobots
            // debugPrint("\(numRobots) \(res)-collecting robot collects \(numRobots) \(res). You now have \(resources[res]!) \(res).")
        }
    }

    // Returns the maximum number of geodes that this factory can collect.
    func run() -> Int {
        if isFinished {
            return geodes
        }

        var maxGeodes = 0
        for robot in Resource.allCases {
            if canBuild(robot) && shouldBuild(robot) {
                let newFactory = factory(afterBuilding: robot)
                let geodes = newFactory.run()
                if geodes > maxGeodes {
                    maxGeodes = geodes
                }
            }
        }
        
        return maxGeodes
    }
}

final class Day19: AOCDay {
    private let blueprints: [(Int, [Robot])]

    init(input: String) {
        blueprints = input.lines.map { line in
            // Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
            let ints = line.allInts()
            let ore = Robot(collects: .ore, costs: [(ints[1], .ore)])
            let clay = Robot(collects: .clay, costs: [(ints[2], .ore)])
            let obsidian = Robot(collects: .obsidian, costs: [(ints[3], .ore), (ints[4], .clay)])
            let geode = Robot(collects: .geode, costs: [(ints[5], .ore), (ints[6], .obsidian)])
            return (ints[0], [ore, clay, obsidian, geode])
        }
    }

    func part1() -> Int {
        var sum = 0
        for (id, blueprint) in blueprints {
            let factory = Factory(blueprint, minutesToRun: 24)
            let geodes = factory.run()
            sum += geodes * id
        }
        return sum
    }

    func part2() -> Int {
        var product = 1
        for (_, blueprint) in blueprints.prefix(3) {
            let factory = Factory(blueprint, minutesToRun: 32)
            let geodes = factory.run()
            product *= geodes
        }
        return product
    }

    private static func parse(_ line: String) -> (Int, [Robot]) {
        // Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
        let ints = line.allInts()
        let ore = Robot(collects: .ore, costs: [(ints[1], .ore)])
        let clay = Robot(collects: .clay, costs: [(ints[2], .ore)])
        let obsidian = Robot(collects: .obsidian, costs: [(ints[3], .ore), (ints[4], .clay)])
        let geode = Robot(collects: .geode, costs: [(ints[5], .ore), (ints[6], .obsidian)])
        return (ints[0], [ore, clay, obsidian, geode])
    }
}
