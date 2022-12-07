//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/7
//

import AoCTools

private enum Line {
    case cd(String)
    case ls
    case file(Int)
    case dir(String)

    init(_ str: String) {
        let parts = str.components(separatedBy: " ")
        if parts[0] == "$" {
            // command
            if parts[1] == "cd" {
                self = .cd(parts[2])
            } else {
                assert(parts[1] == "ls")
                self = .ls
            }
        } else {
            // output
            if parts[0] == "dir" {
                self = .dir(parts[1])
            } else if let size = Int(parts[0]) {
                self = .file(size)
            } else {
                fatalError()
            }
        }
    }
}

private struct Directory: Hashable, CustomStringConvertible {
    private let components: [String]

    init(_ components: [String] = []) {
        self.components = components
    }

    var depth: Int { components.count }

    static let root = Directory(["^"])

    func chdir(to dir: String) -> Directory {
        if dir == ".." {
            assert(components.count > 1)
            return Directory(components.dropLast())
        } else if dir == "/" {
            return Self.root
        } else {
            return Directory(components + [dir])
        }
    }

    var description: String {
        components.joined(separator: "/")
    }
}

final class Day07: AOCDay {
    private let lines: [Line]
    private var totals: [Directory: Int]?

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput

        lines = input.lines.map { Line($0) }
    }

    func part1() -> Int {
        let totals = diskUsage()
        self.totals = totals

        return totals.values
            .filter { $0 <= 100000 }
            .reduce(0, +)
    }

    func part2() -> Int {
        let diskSize = 70000000
        let requiredFree = 30000000

        let totals = self.totals ?? diskUsage()

        let rootSize = totals[.root]!
        let currentFree = diskSize - rootSize

        return totals.values
            .sorted(by: <)
            .filter { currentFree + $0 >= requiredFree }
            .first!
    }

    private func diskUsage() -> [Directory: Int] {
        var usage = [Directory: Int]()
        var cwd = Directory()

        for line in lines {
            switch line {
            case .ls, .dir:
                continue
            case .file(let size):
                usage[cwd, default: 0] += size
            case .cd(let dir):
                let newDir = cwd.chdir(to: dir)
                if dir == ".." {
                    usage[newDir, default: 0] += usage[cwd]!
                }
                cwd = newDir
            }
        }
        while cwd != .root {
            let parent = cwd.chdir(to: "..")
            usage[parent, default: 0] += usage[cwd]!
            cwd = parent
        }

        return usage
    }
}
