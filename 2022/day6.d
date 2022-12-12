import core.bitop;
import std.stdio;
import std.conv;

int char_to_bitpos(char c) {
  return 1 << (c - 'a');
}

int main(string[] argv) {
  auto f = File("day6.input", "r");
  auto siz = f.size();
  char[] data = new char[siz];
  f.rawRead(data);
  ulong pos;
  // In theory, you could jump > 1 character if you saw sth like yxxz, but it's
  // a small optimisation - and you need to keep track of more.
  // Larger windows make this more valuable
  auto payload_size = to!int(argv[1]);
  outer:
  for(int i = payload_size; i < siz; i++) {
    int field = 0;
    for(int j = i - payload_size; j < i; j++) {
      field |= char_to_bitpos(data[j]);
    }
    if(popcnt(field) == payload_size) {
      pos = i;
      break outer;
    }
  }
  writeln("Match at position ", pos, ", characters ",
      data[pos - payload_size.. pos]);
  return 0;
}
