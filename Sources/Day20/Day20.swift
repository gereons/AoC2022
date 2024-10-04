//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/20
//

import AoCTools

private class Node {
    let value: Int
    let shift: Int
    var next: Node?
    var previous: Node?

    init(value: Int, shift: Int) {
        self.value = value
        self.shift = shift
    }
}

final class Day20: AOCDay {
    private let coordinates: [Int]

    init(input: String) {
        coordinates = input.lines.map { Int($0)! }
    }

    func part1() -> Int {
        let circle = setupCircle(from: coordinates)

        rotate(circle)

        return groveCoordinates(from: circle)
    }

    func part2() -> Int {
        let circle = setupCircle(from: coordinates, key: 811589153)

        for _ in 0..<10 {
            rotate(circle)
        }

        return groveCoordinates(from: circle)
    }

    private func groveCoordinates(from circle: [Node]) -> Int {
        var current = circle.first { $0.value == 0 }
        var sum = 0
        for r in 1...3000 {
            current = current?.next
            if r.isMultiple(of: 1000) {
                sum += current!.value
            }
        }
        return sum
    }

    private func setupCircle(from data: [Int], key: Int = 1) -> [Node] {
        let circle = data.map {
            Node(value: $0 * key, shift: ($0 * key) % (data.count - 1))
        }

        for (n1, n2) in circle.adjacentPairs() {
            n1.next = n2
            n2.previous = n1
        }
        circle.first?.previous = circle.last
        circle.last?.next = circle.first

        return circle
    }

    private func rotate(_ circle: [Node]) {
        for node in circle {
            var shift = abs(node.shift)
            var value = node.value
            // switch direction if it's shorter
            if shift > circle.count / 2 {
                shift = circle.count - shift - 1
                value = -value
            }

            for _ in 0 ..< shift {
                if value < 0 {
                    swap(node.previous!, node)
                } else {
                    swap(node, node.next!)
                }
            }
        }
    }

    private func swap(_ lhs: Node, _ rhs: Node) {
        let prev = lhs.previous
        let next = rhs.next

        next?.previous = lhs
        lhs.previous = rhs
        lhs.next = next
        rhs.previous = prev
        rhs.next = lhs
        prev?.next = rhs
    }
}
