//
// Advent of Code 2022
//
// https://adventofcode.com/2022/day/13
//

import AoCTools
import Foundation

final class Day13: AOCDay {
    init(rawInput: String? = nil) {
        let input = rawInput ?? Self.rawInput

        for str in input.lines where !str.isEmpty {
            let list = Parser.createList(from: str)
            print(str, list)
        }
    }
    
    func part1() -> Int {
        return 0
    }

    func part2() -> Int {
        return 0
    }
}

extension Day13 {
    struct List: Equatable {
        let integers: [Int]
        let lists: [List]

        init(integers: [Int] = [], lists: [List] = []) {
            self.integers = integers
            self.lists = lists
        }
    }

    enum TokenType {
        case obracket
        case cbracket
        case integer
        case comma
    }

    struct Token {
        let type: TokenType
        let value: Int?
    }

    struct Tokenizer {
        static func tokenize(packet: String) -> [Token] {
            var tokens = [Token]()
            var idx = 0
            while idx < packet.count {
                let ch = packet[idx]
                switch ch {
                case "[": tokens.append(Token(type: .obracket, value: nil))
                case "]": tokens.append(Token(type: .cbracket, value: nil))
                case ",": tokens.append(Token(type: .comma, value: nil))
                case "0"..."9":
                    let value = Int(String(ch))!
                    while
                    tokens.append(Token(type: .integer, value: int))
                default:
                    continue
                }
            }
            return tokens
        }
    }

    class Parser {
        private var tokens: [Token]

        init(tokens: [Token]) {
            self.tokens = tokens
        }

        static func createList(from packet: String) -> List {
            let parser = Parser(tokens: Tokenizer.tokenize(packet: packet))
            return parser.list()
        }

        private func list() -> List {
            var integers = [Int]()
            var lists = [List]()

            consume(.obracket)
            if peek(.integer) {
                integers = ints()
            }
            if peek(.obracket) {
                
            }
            consume(.cbracket)

            return List(integers: integers, lists: lists)
        }

        private func ints() -> [Int] {
            var value = 0
            var ints = [Int]()

            while true {
                while peek(.integer) {
                    value *= 10
                    let i = Int(String(consume(.integer).value))!
                    value += i
                }
                ints.append(value)
                value = 0
                if peek(.comma) {
                    consume(.comma)
                } else {
                    break
                }
            }

            return ints
        }

        private func peek(_ expected: TokenType) -> Bool {
            guard !tokens.isEmpty else { return false }
            return tokens[0].type == expected
        }

        @discardableResult
        private func consume(_ expected: TokenType) -> Token {
            if tokens[0].type == expected {
                return tokens.remove(at: 0)
            } else {
                fatalError("expected \(expected), got \(tokens[0].type)")
            }
        }
    }
}
*/
