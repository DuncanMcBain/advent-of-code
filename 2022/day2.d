import std.stdio;
import std.format.read;
import std.typecons;

int main() {
  auto f = File("day2.input", "r");
  char[] line;
  int score = 0;
  Tuple!(char, char)[] inputs;
  while(f.readln(line)) {
    char them, us;
    formattedRead(line, "%c %c", them, us);
    inputs ~= tuple(them, us);
  }
  foreach(elem; inputs) {
    // D doesn't have structured bindings :(
    auto them = elem[0];
    auto us = elem[1];
    score += us - 'X' + 1;
    char offset = 'X' - 'A';
    // draw
    if((us - offset) == them) {
      score += 3;
      continue;
    }
    auto losswin = (char them, char loss, char win) {
      if(them == loss)
        return 0;
      if(them == win)
        return 6;
      assert(0);
    };
    if(us == 'X') {
      score += losswin(them, 'B', 'C');
    } else if(us == 'Y') {
      score += losswin(them, 'C', 'A');
    } else { // us == 'Z'
      score += losswin(them, 'A', 'B');
    }
  }
  writeln("total score: ", score);
  score = 0;
  auto beats = ['A': 2, 'B': 3, 'C': 1];
  auto loses = ['A': 3, 'B': 1, 'C': 2];
  auto draws = ['A': 1, 'B': 2, 'C': 3];
  foreach(elem; inputs) {
    auto them = elem[0];
    auto wld = elem[1];
    final switch(wld) {
      case 'X': // lose
        score += loses[them] + 0; continue;
      case 'Y': // draw
        score += draws[them] + 3; continue;
      case 'Z': // win
        score += beats[them] + 6; continue;
    }
  }
  writeln("updated score: ", score);
  return 0;
}
