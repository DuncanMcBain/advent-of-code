import std.conv;
import std.stdio;

// Maps a-z to 1-26, A-Z to 27-52
// 'a' - 1 == '`' so c - 'a' + 1 == c - '`'
// '&' is dec 38, so maps 'A' == 65 to 27 and so on
int priority(char c) {
  return 'a' <= c && c <= 'z' ? c - '`' : c - '&';
}

int main() {
  auto f = File("day3.input", "r");
  string[] lines;
  {
    char[] line;
    while(f.readln(line)) {
      lines ~= to!string(line);
    }
  }
  assert(lines.length % 3 == 0);
  int sum = 0;
  foreach(line; lines) {
    auto first  = line[0 .. $/2];
    auto second = line[$/2 .. $];
    char c;
    found:
    foreach(elem; first) {
      foreach(e; second) {
        if(elem == e) {
          c = e;
          break found;
        }
      }
    }
    sum += priority(c);
  }
  writeln("Priority sum: ", sum);

  char[64] potentials;
  int score = 0;
  for (int idx = 0; idx < lines.length; idx += 3) {
    int p_idx = 0;
    foreach(c; lines[idx]) {
      foreach(d; lines[idx + 1]) {
        if(c == d)
          potentials[p_idx++] = c;
      }
    }
    next:
    // iterating this order means we never have to clear potentials
    foreach(c; potentials) {
      foreach(d; lines[idx + 2]) {
        if(c == d) {
          score += priority(c);
          break next;
        }
      }
    }
  }
  writeln("badges score: ", score);
  return 0;
}
