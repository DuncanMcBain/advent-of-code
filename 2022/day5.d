import std.array;
import std.format.read;
import std.format.spec;
import std.range;
import std.regex;
import std.stdio;

/* Craterangement looks like this:
 * [A] [B] [C]
 *  1   2   3
 * what's the top crate in all columns?
 */

int main() {
  auto f = File("day5.input", "r");
  auto find_stacks = ctRegex!(`\[`);
  auto input = f.byLineCopy().array();
  ulong loc;
  foreach(i, line; input) {
    if(!matchFirst(line, find_stacks)) {
      loc = i; break;
    }
  }
  auto spec = singleSpec("%d");
  auto stack_count = input[loc].split()[$-1].unformatValue!int(spec);
  char[][] crate_stacks;
  crate_stacks.length = stack_count;
  foreach(line; retro(input[0 .. loc])) {
    foreach(idx; 0 .. stack_count) {
      auto i = 1 + idx * 4;
      if(i < line.length) {
        if(line[i] != ' ')
          crate_stacks[idx] ~= line[i];
      }
    }
  }
  writeln("Pre-moves: ", crate_stacks);
  foreach(idx, insn; input[loc .. $]) {
    if(insn.length == 0 || insn[0] != 'm') continue;
    int crates, from, to;
    formattedRead(insn, "move %d from %d to %d", crates, from, to);
    from -= 1; to -= 1;
    // first answer
    /*for(int i = 0; i < crates; i++) {
      crate_stacks[to] ~= crate_stacks[from].back();
      crate_stacks[from].popBack();
    }*/
    crate_stacks[to] ~= crate_stacks[from][$ - crates .. $];
    crate_stacks[from].popBackN(crates);
  }
  writeln(crate_stacks);
  return 0;
}
