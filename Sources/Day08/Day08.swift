//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/8
//

import AoCTools

final class Day08: AOCDay {

    let trees: [[Int]]

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput

        trees = input.lines.map { line in
            line.map { Int(String($0))! }
        }
    }

    func part1() -> Int {
        let maxX = trees[0].count - 1
        let maxY = trees.count - 1
        var innerVisible = 0
        for y in 1 ..< trees.count - 1 {
            for x in 1 ..< trees[0].count - 1 {
                let height = trees[y][x]
                var visible: [Point.Direction: Bool] = [.n: true, .w: true, .e: true, .s: true]
                for direction in Point.Direction.orthogonal {
                    var n = Point(x, y).moved(direction)
                    while 0...maxX ~= n.x && 0...maxY ~= n.y {
                        if trees[n.y][n.x] >= height {
                            visible[direction] = false
                            break
                        }
                        n = n.moved(direction)
                    }
                }
                if visible.count(where: { $0.value }) > 0 {
                    innerVisible += 1
                }
            }
        }

        // inner + top/bottom border + left/right border
        return innerVisible + (maxX + 1) * 2 + (maxY - 1) * 2
    }

    func part2() -> Int {
        let maxX = trees[0].count - 1
        let maxY = trees.count - 1

        var scenicScores = [Int]()
        for y in 1 ..< trees.count - 1 {
            for x in 1 ..< trees[0].count - 1 {
                let height = trees[y][x]
                var visible = [Point.Direction: Int]()
                for direction in Point.Direction.orthogonal {
                    var n = Point(x, y).moved(direction)
                    while 0...maxX ~= n.x && 0...maxY ~= n.y {
                        visible[direction, default: 0] += 1
                        if trees[n.y][n.x] >= height {
                            break
                        }
                        n = n.moved(direction)
                    }
                }
                let score = visible.values.reduce(1, *)
                scenicScores.append(score)
            }
        }

        return scenicScores.max()!
    }
}
