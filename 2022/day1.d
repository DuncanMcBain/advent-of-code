import std.algorithm.iteration;
import std.algorithm.searching;
import std.algorithm.sorting;
import std.conv;
import std.functional;
import std.stdio;
import std.typecons;

struct Elf {
  int cals = 0;

  this(int calories) { cals = calories; }
};

int main() {
  auto input = File("day1.input", "r");
  char[] line;
  Elf[] elves;
  int accum = 0;
  while (input.readln(line)) {
    if (line == "\n") {
      elves ~= Elf(accum);
      accum = 0;
      continue;
    }
    accum += to!int(line[0 .. $-1]);
  }
  auto max = elves.maxElement!"a.cals"();
  writeln("Maximal calorie count: ", max);
  auto sorted = elves.sort!"a.cals > b.cals"();
  writeln("Top 3: ", elves[0 .. 3]);
  writeln("Top 3 sum: ", elves[0 .. 3].map!(a => a.cals)().sum());
  return 0;
}
