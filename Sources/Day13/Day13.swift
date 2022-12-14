//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/13
//

import AoCTools
import Foundation

private enum Data {
    case int(Int)
    indirect case list([Data])
}

extension Data: CustomStringConvertible {
    var description: String {
        var descr = ""
        switch self {
        case .int(let int):
            descr.append("\(int),")
        case .list(let list):
            descr.append("[")
            list.forEach {
                descr.append($0.description)
            }
            descr.append("]")
        }
        return descr
    }
}

// thanks to /u/mayoff on reddit for pointing out how `Decodable` can parse the input
// https://www.reddit.com/r/adventofcode/comments/zkmyh4/2022_day_13_solutions/j00oyl6/?context=3
extension Data: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let c = try decoder.singleValueContainer()
            self = .int(try c.decode(Int.self))
        } catch {
            self = .list(try [Data](from: decoder))
        }
    }
}

extension Data: Comparable {
    static func < (lhs: Data, rhs: Data) -> Bool {
        switch (lhs, rhs) {
        case (.int(let i1), .int(let i2)):
            return i1 < i2
        case (.list, .int(let i2)):
            return lhs < .list([.int(i2)])
        case (.int(let i1), .list):
            return .list([.int(i1)]) < rhs
        case (.list(let l1), .list(let l2)):
            for zipped in zip(l1, l2) {
                if zipped.0 < zipped.1 { return true }
                if zipped.0 > zipped.1 { return false }
            }
            return l1.count < l2.count
        }
    }
}

final class Day13: AOCDay {
    private let packets: [Pair<Data, Data>]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput

        var packets = [Pair<Data, Data>]()
        let decoder = JSONDecoder()
        for lines in input.lines.split(whereSeparator: \.isEmpty) {
            let d1 = try! decoder.decode(Data.self, from: lines.first!.data(using: .utf8)!)
            let d2 = try! decoder.decode(Data.self, from: lines.last!.data(using: .utf8)!)
            packets.append(Pair(d1, d2))
        }

        self.packets = packets
    }
    
    func part1() -> Int {
        var count = 0
        for (index, packet) in packets.enumerated() {
            let less = packet.first < packet.second
            if less {
                count += index + 1
            }
        }
        return count
    }

    func part2() -> Int {
        var allData = packets.flatMap { [$0.first, $0.second] }

        let special1 = Data.list([.list([.int(2)])])
        let special2 = Data.list([.list([.int(6)])])
        allData.append(special1)
        allData.append(special2)
        allData.sort(by: <)

        let pos1 = allData.firstIndex(of: special1)!
        let pos2 = allData.firstIndex(of: special2)!
        return (pos1 + 1) * (pos2 + 1)
    }
}
