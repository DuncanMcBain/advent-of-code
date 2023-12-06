import std.ascii;
import std.range;
import std.stdio;

bool match(string name, string line) {
  if(name.length > line.length)
    return false;
  foreach(i, c; name) {
    if(c != line[i])
      return false;
  }
  return true;
}

int[] parse(string slice) {
  int idx = 0;
  int[] results;
  while(slice.length) {
    auto c = slice[0];
    if(isDigit(c)) {
      results ~= c - '0';
    } else {
      switch(c) {
        case 'o':
          if(match("one", slice))
            results ~= 1;
          break;
        case 't':
          if(match("two", slice))
            results ~= 2;
          else if(match("three", slice))
            results ~= 3;
          break;
        case 'f':
          if(match("four", slice))
            results ~= 4;
          else if(match("five", slice))
            results ~= 5;
          break;
        case 's':
          if(match("six", slice))
            results ~= 6;
          else if(match("seven", slice))
            results ~= 7;
          break;
        case 'e':
          if(match("eight", slice))
            results ~= 8;
          break;
        case 'n':
          if(match("nine", slice))
            results ~= 9;
          break;
        default:
      }
    }
    slice = slice[1 .. $];
  }
  return results;
}

int main() {
  auto input = File("day1.input", "r");
  auto lines = input.byLineCopy().array();
  int first, last, res, accum = 0;
  foreach(line; lines) {
    foreach(c; line) {
      if(isDigit(c)) {
        first = c - '0';
        break;
      }
    }
    foreach(c; retro(line)) {
      if(isDigit(c)) {
        last = c - '0';
        break;
      }
    }
    res = 10 * first + last;
    accum += res;
  }
  writeln("Sum: ", accum);
  // reset for the text versions
  accum = 0;
  foreach(line; lines) {
    auto nums = parse(line);
    accum += 10 * nums[0] + nums[$-1];
  }
  writeln("Sum: ", accum);
  return 0;
}
