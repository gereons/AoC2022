#!/bin/sh

YR=2022
DAY=$1

if [ -z "$DAY" ]; then
    DAY=$(date +%e | tr -d " ")
fi

if [ -r .aoc-session ]; then
    AOC_SESSION=$(cat .aoc-session)
fi

if [ -z "$AOC_SESSION" ]; then
    echo "no session found"
    exit 1
fi

echo "getting puzzle input for $YR day $DAY"

D2=$(printf "%02d" $DAY)

TMP=.input.$$.tmp
UA="https://github.com/gereons/aoc2022"
curl -s https://adventofcode.com/$YR/day/$DAY/input --cookie "session=$AOC_SESSION" -H "User-Agent: $UA" >$TMP

(
cat <<END
//
// Advent of Code $YR - input for day $D2
//

extension Day$D2 {
static let input = #"""
END

cat $TMP

cat <<END
"""#
}
END
) >Sources/Inputs/Day$D2+Input.swift

rm $TMP
