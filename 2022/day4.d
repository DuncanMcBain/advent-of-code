import std.algorithm.mutation;
import std.stdio;
import std.format.read;

int main() {
  char[] line;
  auto f = File("day4.input", "r");
  int full_overlaps = 0;
  int partial_overlaps = 0;
  while(f.readln(line)) {
    int a,b,c,d;
    formattedRead(line, "%d-%d,%d-%d",a,b,c,d);
    partial_overlaps += (c <= b) && !(d < a);
    // left or right? Right is true, ties are acceptable
    bool lr = (b - a) < (d - c);
    // overlap is small_lower geq big_lower, small_higher leq big_higher
    if(lr) {
      swap(a, c);
      swap(b, d);
    }
    full_overlaps += (c >= a) && (d <= b);
  }
  writeln("number of full overlaps: ", full_overlaps);
  writeln("number of partial overlaps: ", partial_overlaps);
  return 0;
}
