import std.algorithm;
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
  return 0;
}

