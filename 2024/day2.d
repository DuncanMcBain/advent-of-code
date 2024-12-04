import std.algorithm;
import std.array;
import std.conv;
import std.functional;
import std.algorithm.comparison;
import std.math.algebraic;
import std.range;
import std.stdio;

int main() {
  auto input = File("day2.input", "r");
  auto lines = input.byLineCopy().array();
  int[][] reports;
  int safe_reports = 0;
  int smoothed_safe_reports = 0;
  foreach(line; lines) {
    auto nums = line.split.map!(to!int);
    auto diffs = zip(nums, nums.dropOne).map!(a => a[0] - a[1]);
    bool safe = all!"a.abs < 4 && a.abs > 0"(diffs) &&
      (all!"a < 0"(diffs) || all!"a > 0"(diffs));
    safe_reports += safe;
    if (!safe) {
      auto real_nums = nums.array;
      foreach (i; iota(nums.length)) {
        auto new_nums = real_nums.take(i) ~ real_nums.drop(i + 1);
        auto new_diffs = zip(new_nums, new_nums.dropOne).map!(a => a[0] - a[1]);
        bool new_safe = all!"a.abs < 4 && a.abs > 0"(new_diffs) &&
          (all!"a < 0"(new_diffs) || all!"a > 0"(new_diffs));
        if (new_safe) {
          smoothed_safe_reports++; break;
        }
      }
    }
  }
  writeln(safe_reports);
  writeln(smoothed_safe_reports + safe_reports);
  return 0;
}

