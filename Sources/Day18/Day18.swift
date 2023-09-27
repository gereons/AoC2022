//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/18
//

import AoCTools

private class Cube {
    enum Contents {
        case water, lava
    }
    let minX, maxX, minY, maxY, minZ, maxZ: Int

    var points: [Point3: Contents]

    init(points: [Point3]) {
        minX = points.min(of: \.x)! - 1
        maxX = points.max(of: \.x)! + 1
        minY = points.min(of: \.y)! - 1
        maxY = points.max(of: \.y)! + 1
        minZ = points.min(of: \.z)! - 1
        maxZ = points.max(of: \.z)! + 1

        let lava = [Contents](repeating: .lava, count: points.count)
        self.points = Dictionary(uniqueKeysWithValues: zip(points, lava))
    }

    var start: Point3 { Point3(minX, minY, minZ) }

    func contains(_ point: Point3) -> Bool {
        point.x >= minX && point.x <= maxX &&
        point.y >= minY && point.y <= maxY &&
        point.z >= minZ && point.z <= maxZ
    }
}

final class Day18: AOCDay {
    let droplet: [Point3]

    init(input: String? = nil) {
        let input = input ?? Self.input
        droplet = input.lines.map { line in
            let parts = line.components(separatedBy: ",")
            return Point3(Int(parts[0])!, Int(parts[1])!, Int(parts[2])!)
        }
    }

    func part1() -> Int {
        let sixes = [Int](repeating: 6, count: droplet.count)
        var sides = Dictionary(uniqueKeysWithValues: zip(droplet, sixes))

        for cube in droplet {
            let neighbors = cube.neighbors().filter { sides[$0] != nil }
            sides[cube]! -= neighbors.count
        }

        return sides.values.reduce(0, +)
    }

    func part2() -> Int {
        let cube = Cube(points: droplet)

        floodFill(cube, from: cube.start)

        let water = cube.points.filter { $0.value == .water }.keys

        var sides = 0
        for p in water {
            let n = p.neighbors().filter { cube.points[$0] == .lava }
            sides += n.count
        }

        return sides
    }

    private func floodFill(_ cube: Cube, from start: Point3) {
        cube.points[start] = .water

        let neighbors = start.neighbors()
            .filter { cube.contains($0) && cube.points[$0] == nil }
        
        for n in neighbors {
            floodFill(cube, from: n)
        }
    }
}
