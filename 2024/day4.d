import std.array;
import std.range;
import std.stdio;

auto permute_pairs(Range)(Range r, Range s) {
  typeof(zip(r,s).array) pairs;
  foreach (elem; s) {
    auto all_same = repeat(elem, s.length);
    pairs ~= zip(r, all_same.array).array;
  }
  return pairs;
}

int main() {
  string goal = "XMAS";
  auto word_size = goal.length;
  auto input = File("day4.input", "r");
  auto lines = input.byLineCopy().array();
  char[][] wordsearch;
  auto len = lines[0].length;
  auto scaled_size = len + 2 * word_size; // horizontal halo
  auto add_lines = {
    auto blank_line = '.'.repeat(scaled_size).array;
    foreach(i; 0 .. word_size)
      wordsearch ~= blank_line;
  };
  add_lines();
  foreach(line; lines) {
    wordsearch ~=
      ('.'.repeat(word_size).array ~ line.dup ~ '.'.repeat(word_size).array);
  }
  add_lines();
  int[] dirs = [-1, 0, 1];
  int accum = 0;
  foreach(i; iota(word_size, scaled_size - word_size)) {
    foreach(j; iota(word_size, wordsearch.length - word_size)) {
      foreach(pair; permute_pairs(dirs, dirs)) {
        bool found = true;
        foreach(p, elem; goal) {
          auto x = i + pair[0] * p;
          auto y = j + pair[1] * p;
          found &= elem == wordsearch[y][x];
        }
        accum += found;
      }
    }
  }
  writeln("XMAS count:", accum);
  accum = 0;
  foreach(i; iota(word_size, scaled_size - word_size)) {
    foreach(j; iota(word_size, wordsearch.length - word_size)) {
      if(wordsearch[j][i] == 'A') {
        auto pairs = permute_pairs([-1, 1], [-1, 1]);
        auto tl = wordsearch[j-1][i-1];
        auto tr = wordsearch[j-1][i+1];
        auto bl = wordsearch[j+1][i-1];
        auto br = wordsearch[j+1][i+1];
        bool fwd = (bl == 'M' && tr == 'S') || (bl == 'S' && tr == 'M');
        bool bwd = (tl == 'M' && br == 'S') || (tl == 'S' && br == 'M');
        accum += fwd && bwd;
      }
    }
  }
  writeln("X-MASSes: ", accum);

  return 0;
}

