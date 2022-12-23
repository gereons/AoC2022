//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/17
//

import AoCTools

private struct Shape {
    // top left is at (0, 0)
    let points: [Point]
    let height: Int

    func moved(to direction: Direction, _ steps: Int = 1) -> Shape {
        Shape(points: points.map { $0.moved(to: direction, steps: steps) }, height: height)
    }

    static let dash = Shape(points: [Point(0,0), Point(1,0), Point(2,0), Point(3,0)], height: 1)
    static let plus = Shape(points: [Point(1,0), Point(0,1), Point(1,1), Point(2,1), Point(1,2)], height: 3)
    static let ell = Shape(points: [Point(2,0), Point(2,1), Point(2,2), Point(1,2), Point(0,2)], height: 3)
    static let beam = Shape(points: [Point(0,0), Point(0,1), Point(0,2), Point(0,3)], height: 4)
    static let block = Shape(points: [Point(0,0), Point(0,1), Point(1,0), Point(1,1)], height: 2)
}

private class Playfield {
    private var grid = [Point: Bool]()
    private var minY: Int
    private var highYs: [Int]

    var accumulatedHeight: Int { -minY + 1 }

    init() {
        minY = 1
        highYs = [Int](repeating: 1, count: 7)
        Point(-1, 1).line(to: Point(7,1)).forEach {
            grid[$0] = true
        }
    }

    func add(_ shape: Shape) {
        shape.points.forEach { p in
            grid[p] = true
            highYs[p.x] = min(highYs[p.x], p.y)
        }
        self.minY = min(self.minY, shape.points.min(of: \.y)!)
    }

    func possiblePlacement(_ shape: Shape) -> Bool {
        shape.points.allSatisfy {
            (0...6) ~= $0.x && grid[$0] == nil
        }
    }

    // highest point in every column, normalized so that the lowest point is at y==0
    func skyline() -> [Point] {
        var maxY = Int.min
        let points = (0...6).map { x in
            let y = highYs[x]
            maxY = max(maxY, y)
            return Point(x, y)
        }

        return points.map { $0.moved(to: .s, steps: -maxY)}
    }

    func draw() {
        Grid(points: grid).draw()
    }
}

private struct Key: Hashable {
    let skyline: [Point]
    let shapeIndex: Int
    let jetIndex: Int
}

final class Day17: AOCDay {
    let jets: [Character]
    private var jetIndex = 0

    private let shapes: [Shape] = [ .dash, .plus, .ell, .beam, .block ]
    private var shapeIndex = 0

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput
        jets = Array(input)
    }

    func part1() -> Int {
        jetIndex = 0
        shapeIndex = 0

        var playfield = Playfield()
        for _ in 0..<2022 {
            playTetris(in: &playfield)
        }
        return playfield.accumulatedHeight
    }

    func part2() -> Int {
        jetIndex = 0
        shapeIndex = 0
        let rocks = 1_000_000_000_000
        var seen = [Key: (Int, Int)]()

        var playfield = Playfield()
        for block in 1 ..< Int.max {
            playTetris(in: &playfield)
            let key = Key(skyline: playfield.skyline(), shapeIndex: shapeIndex, jetIndex: jetIndex)
            if let (start, height) = seen[key] {
                let heightGain = playfield.accumulatedHeight - height
                let loopLen = block - start
                let loops = (rocks - start) / loopLen
                let remainder = (rocks - start) - (loops * loopLen)
                for _ in 0..<remainder {
                    playTetris(in: &playfield)
                }

                // -1 loops because we've stopped at the end of the first
                return playfield.accumulatedHeight + ((loops - 1) * heightGain)
            }
            seen[key] = (block, playfield.accumulatedHeight)
        }

        return 0
    }

    private func playTetris(in playfield: inout Playfield) {
        var shape = nextShape()
        // set start position
        shape = shape
            .moved(to: .n, playfield.accumulatedHeight + 2 + shape.height)
            .moved(to: .e, 2)

        var atRest = false
        while !atRest {
            // jet move
            let movedByJet = shape.moved(to: nextJet())
            if playfield.possiblePlacement(movedByJet) {
                shape = movedByJet
            }

            // drop down
            let down = shape.moved(to: .s)
            if playfield.possiblePlacement(down) {
                shape = down
            } else {
                atRest = true
            }
        }
        playfield.add(shape)
    }

    private func nextJet() -> Direction {
        defer { jetIndex = (jetIndex + 1) % jets.count }
        return jets[jetIndex] == "<" ? .w : .e
    }

    private func nextShape() -> Shape {
        defer { shapeIndex = (shapeIndex + 1) % shapes.count }
        return shapes[shapeIndex]
    }
}
