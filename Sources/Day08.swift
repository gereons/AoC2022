//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/8
//

import AoCTools

final class Day08: AdventOfCodeDay {
    let title = "Treetop Tree House"
    
    let trees: [[Int]]

    init(input: String) {
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
                var visible: [Direction: Bool] = [.n: true, .w: true, .e: true, .s: true]
                for direction in Direction.orthogonal {
                    var n = Point(x, y).moved(to: direction)
                    while 0...maxX ~= n.x && 0...maxY ~= n.y {
                        if trees[n.y][n.x] >= height {
                            visible[direction] = false
                            break
                        }
                        n = n.moved(to: direction)
                    }
                }
                if visible.values.first(where: { $0 }) != nil {
                    innerVisible += 1
                }
            }
        }

        // inner + top/bottom border + left/right border
        return innerVisible + maxX * 2 + maxY * 2
    }

    func part2() -> Int {
        let maxX = trees[0].count - 1
        let maxY = trees.count - 1

        var scenicScore = Int.min
        for y in 1 ..< trees.count - 1 {
            for x in 1 ..< trees[0].count - 1 {
                let height = trees[y][x]
                var visible: [Direction: Int] = [.n: 0, .w: 0, .e: 0, .s: 0]
                for direction in Direction.orthogonal {
                    var n = Point(x, y).moved(to: direction)
                    while 0...maxX ~= n.x && 0...maxY ~= n.y {
                        visible[direction]! += 1
                        if trees[n.y][n.x] >= height {
                            break
                        }
                        n = n.moved(to: direction)
                    }
                }
                let score = visible.values.reduce(1, *)
                scenicScore = max(scenicScore, score)
            }
        }

        return scenicScore
    }
}
