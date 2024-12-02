import std.algorithm;
import std.array;
import std.format.read;
import std.functional;
import std.math.algebraic;
import std.range;
import std.stdio;

/* TODO: single pass for this probably looks like preprocessing this to uniq
   the left array and count when you hit a value that is there many times or
   sth. Or lookahead on the ls array, then do the sums for the first hit,
   then add the correct no occurrences, then walk like that.*/

alias sub = binaryFun!("a - b");

int main() {
  auto input = File("day1.input", "r");
  auto lines = input.byLineCopy().array();
  int[] ls;
  int[] rs;
  foreach(line; lines) {
    int l,r;
    formattedRead(line, "%d   %d", l, r);
    ls ~= l;
    rs ~= r;
  }
  assert(ls.length == rs.length);

  ls.sort();
  rs.sort();

  auto res = zip(ls, rs).map!(a => sub(a.expand)).map!abs.sum();
  writeln(res);

  res = 0;
  foreach(val; ls)
    res += rs.count(val) * val;

  writeln(res);

  return 0;
}

