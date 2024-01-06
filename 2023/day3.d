import std.range;
import std.stdio;
import std.typecons;

alias PartNumber = Tuple!(int, "value", size_t, "start", size_t, "end");

int main() {
  auto f = File("day3.test", "r");
  char[] line;
  byte[] data;
  auto len = f.readln(line);
  f.rewind();
  while(f.readln(line)) {
    data ~= line[0 .. $ - 1];
  }
  auto chunks = chunks(data, len - 1);
  foreach(chunk; chunks) {
    writeln(cast(char[])chunk);
    auto nums = find_numbers(chunk);
    foreach(num; nums)
      write(num.value, ", ");
    writeln();
  }
  return 0;
}

// finds candidate numbers
PartNumber[] find_numbers(byte[] line) {
  PartNumber[] nums;
  PartNumber next = PartNumber(0, 0, 0);
  // Scale puts the read number into the right decimal position
  auto scale = 1u;
  // Tracks if we're still reading out a number
  auto in_number = false;
  // Reading the line in reverse means we don't need to look ahead to know how
  // big the number is before we start, we can just keep looking for digits
  // until we hit a non 0-9 character
  foreach_reverse(i, c; line) {
    auto chr = c - '0';
    // True when we're in the ASCII range of number characters
    if(chr < 10 && chr > -1) {
      // Push the end of the number on each time we read another digit
      if(in_number)
        next.end = i;
      // Increment the value by units, tens, hundreds, then go to next
      next.value += chr * scale;
      scale *= 10;
      in_number = true;
      continue;
    }
    // If we're here we are no longer reading a number, so stop by:
    // Setting the start position, appending to the return value,
    // set the next number to 0, reset the scale and notify the loop to
    // stop reading as if we're in the middle of a number
    if(in_number) {
      next.start = i;
      nums ~= next;
      next = PartNumber(0, 0, 0);
      scale = 1;
      in_number = false;
    }
  }
  // Deal with numbers at the start of a line
  if(in_number) {
    next.start = 0;
    nums ~= next;
  }
  return nums;
}

