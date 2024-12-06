import std.algorithm;
import std.algorithm.searching;
import std.conv;
import std.functional;
import std.range;
import std.regex;
import std.stdio;

int main() {
  auto input = File("day3.input", "r");
  auto lines = input.byLineCopy().array();
  auto reg = regex(r"mul\((\d+),(\d+)\)");
  long accum = 0;
  foreach (line; lines) {
    auto matches = matchAll(line, reg);
    foreach(match; matches) {
      auto first = match[1];
      auto second = match[2];
      accum += (to!int(first) * to!int(second));
    }
  }
  writeln(accum);
  accum = 0;
  auto flip = (string a) => a == "do()" ? "don't()" : "do()";
  auto needle = "don't()";
  auto oneline = lines.join(" ");
  do {
    auto tup = findSplit(oneline, needle);
    // found a match - empty if missing - finding "don't" means we are in "do"
    if (tup[1] == "don't()" || (tup[2].empty && needle == "don't()")) {
      auto matches = matchAll(tup[0], reg);
      foreach(match; matches) {
        auto first = match[1];
        auto second = match[2];
        accum += (to!int(first) * to!int(second));
      }
    }
    oneline = tup[2];
    needle = flip(needle);
  } while (oneline.length);
  writeln(accum);
  return 0;
}

