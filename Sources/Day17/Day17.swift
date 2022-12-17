//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/17
//

import AoCTools

private enum Unit: Character, Drawable {
    case rock = "#"
    case wall = "|"
    case air = "."
}

private struct Shape {
    // top left is at (0, 0)
    let points: [Point]
    let height: Int

    var left: Int {
        points.min(of: \.x)!
    }

    var right: Int {
        points.max(of: \.x)!
    }

    func moved(to direction: Point.Direction, _ steps: Int = 1) -> Shape {
        Shape(points: points.map { $0.moved(to: direction, steps: steps) }, height: height)
    }

    static let dash = Shape(points: [Point(0,0), Point(1,0), Point(2,0), Point(3,0)], height: 1)
    static let plus = Shape(points: [Point(1,0), Point(0,1), Point(1,1), Point(2,1), Point(1,2)], height: 3)
    static let ell = Shape(points: [Point(2,0), Point(2,1), Point(2,2), Point(1,2), Point(0,2)], height: 3)
    static let beam = Shape(points: [Point(0,0), Point(0,1), Point(0,2), Point(0,3)], height: 4)
    static let block = Shape(points: [Point(0,0), Point(0,1), Point(1,0), Point(1,1)], height: 2)

    static let shapes = [ dash, plus, ell, beam, block ]

    static func get(_ block: Int) -> Shape {
        shapes[block % shapes.count]
    }
}

private struct Tunnel {
    private(set) var grid = [Point: Unit]()
    private(set) var minY: Int

    var accumulatedHeight: Int { -minY + 1 }

    init() {
        minY = 1
        add(Point(-1, 1).line(to: Point(7,1)), .rock)
    }

    mutating func add(_ shape: Shape) {
        add(shape.points, .rock)
        self.minY = min(self.minY, shape.points.min(of: \.y)!)
    }

    mutating func add(_ points: [Point], _ unit: Unit) {
        points.forEach {
            assert(grid[$0] == nil)
            grid[$0] = unit
        }
    }

    func possiblePlacement(_ shape: Shape) -> Bool {
        shape.points.allSatisfy {
            (0...6) ~= $0.x && grid[$0] == nil
        }
    }

    func draw() {
        Grid(points: grid).draw()
    }
}

final class Day17: AOCDay {
    let jets: [Character]
    private var jetIndex = 0

    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput
        jets = Array(input)
    }

    func part1() -> Int {
        var tunnel = Tunnel()

        for block in 0..<2022 {
            var shape = Shape.get(block)
            // set start position
            shape = shape
                .moved(to: .n, tunnel.accumulatedHeight + 2 + shape.height)
                .moved(to: .e, 2)

            var atRest = false
            while !atRest {
                // jet move
                let movedByJet = shape.moved(to: jet())
                if tunnel.possiblePlacement(movedByJet) {
                    shape = movedByJet
                }

                // drop down
                let down = shape.moved(to: .s)
                if tunnel.possiblePlacement(down) {
                    shape = down
                } else {
                    atRest = true
                }
            }
            tunnel.add(shape)
        }

        return tunnel.accumulatedHeight
    }

    func part2() -> Int {
        return 0
    }

    func jet() -> Point.Direction {
        let ch = jets[jetIndex % jets.count]
        jetIndex += 1
        return ch == "<" ? .w : .e
    }
}

extension Point {
    func line(to end: Point) -> [Point] {
        let dx = (end.x - x).signum()
        let dy = (end.y - y).signum()
        let range = max(abs(x - end.x), abs(y - end.y))
        return (0 ..< range).map { step in
            Point(x + dx * step, y + dy * step)
        }
    }

    func moved(to direction: Direction, steps: Int) -> Point {
        self + direction.offset * steps
    }
}
