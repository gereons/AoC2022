# Advent Of Code 2022

My [AoC 2022](https://adventofcode.com/2022) Solutions in Swift

### Overview

All code for all days is compiled into a single macOS commandline binary, which can be run either from within Xcode or from Terminal.

Each day has at least 3 associated source files: 

* `DayX.swift` for the solution code
* `DayX+Input.swift` for the puzzle input, not included in this repo for [legal reasons](https://www.reddit.com/r/adventofcode/wiki/faqs/copyright/inputs).
* `DayXTests.swift` for the test suite, if the puzzle has test cases

`AoC.swift` has the `main()` function which simply runs one (or all) of the puzzles.

The code relies on my own [AoCTools](https://github.com/gereons/AoCTools) package where I started collecting utility functions for things frequently used in AoC, such as 2d and 3d points, hexagonal grids, an A\* pathfinder and more.

### Xcode

Open the project via the `Package.swift` file (`xed .` from Terminal in the project directory). By default, hitting `Cmd-R` will run the puzzle for the current calendar day. To override this, change `defaultDay` in `AoC.swift`.

`Cmd-U` runs the test suite for all 25 days. Run individual tests by clicking on them in the Test Inspector (`Cmd-6`)

### Commandline

From the commandline, use `swift run` or `swift run -c release`. 

To run the puzzle for a specific day without changing `AoC.swift`, use `swift run AdventOfCode X` to run day `X`. `X` can be a number from 1 to 25 or `all`.

To run tests, use `swift test` for all tests, or e.g. `swift test --filter AoCTests.Day02` to run the tests for day 2.

### Puzzle Inputs

Use the included `input.sh` script to download your puzzle input. To be able to run this script, [grab the session cookie](https://www.reddit.com/r/adventofcode/comments/a2vonl/how_to_download_inputs_with_a_script/) from [adventofcode.com](https://adventofcode.com) and create a `.aoc-session` file with the contents. `input.sh` downloads the input for the current day by default, use `input.sh X` to download day X's input.

<!--- advent_readme_stars table --->
## 2022 Results

| Day | Part 1 | Part 2 |
| :---: | :---: | :---: |
| [Day 1](https://adventofcode.com/2022/day/1) | ⭐ | ⭐ |
| [Day 2](https://adventofcode.com/2022/day/2) | ⭐ | ⭐ |
| [Day 3](https://adventofcode.com/2022/day/3) | ⭐ | ⭐ |
| [Day 4](https://adventofcode.com/2022/day/4) | ⭐ | ⭐ |
| [Day 5](https://adventofcode.com/2022/day/5) | ⭐ | ⭐ |
| [Day 6](https://adventofcode.com/2022/day/6) | ⭐ | ⭐ |
| [Day 7](https://adventofcode.com/2022/day/7) | ⭐ | ⭐ |
| [Day 8](https://adventofcode.com/2022/day/8) | ⭐ | ⭐ |
| [Day 9](https://adventofcode.com/2022/day/9) | ⭐ | ⭐ |
| [Day 10](https://adventofcode.com/2022/day/10) | ⭐ | ⭐ |
| [Day 11](https://adventofcode.com/2022/day/11) | ⭐ | ⭐ |
| [Day 12](https://adventofcode.com/2022/day/12) | ⭐ | ⭐ |
| [Day 13](https://adventofcode.com/2022/day/13) | ⭐ | ⭐ |
| [Day 14](https://adventofcode.com/2022/day/14) | ⭐ | ⭐ |
| [Day 15](https://adventofcode.com/2022/day/15) | ⭐ | ⭐ |
| [Day 16](https://adventofcode.com/2022/day/16) | ⭐ | ⭐ |
| [Day 17](https://adventofcode.com/2022/day/17) | ⭐ | ⭐ |
| [Day 18](https://adventofcode.com/2022/day/18) | ⭐ | ⭐ |
| [Day 19](https://adventofcode.com/2022/day/19) | ⭐ | ⭐ |
| [Day 20](https://adventofcode.com/2022/day/20) | ⭐ | ⭐ |
| [Day 21](https://adventofcode.com/2022/day/21) | ⭐ | ⭐ |
| [Day 22](https://adventofcode.com/2022/day/22) | ⭐ |   |
| [Day 23](https://adventofcode.com/2022/day/23) | ⭐ | ⭐ |
<!--- advent_readme_stars table --->

