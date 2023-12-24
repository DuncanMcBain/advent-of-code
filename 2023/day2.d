import std.array;
import std.format.read;
import std.stdio;
import std.string;
import std.typecons;

// TODO: write a real parser for this you coward

alias Record = Tuple!(int, "red", int, "green", int, "blue");
alias Game = Tuple!(int, "game_id", Record[], "records");

int main() {
  auto f = File("day2.input", "r");
  char[] line;
  Game[] games;
  while(f.readln(line)) {
    Game game;
    int game_id = -1;
    formattedRead(line, "Game %d:%s", game_id, line);
    game.game_id = game_id;
    // this might not work ? last draw has no ;
    while(line.length) {
      auto i = line.indexOf(';');
      // last draw of the game, set i to last element
      if(-1 == i)
        i += line.length;
      auto results = split(line[0 .. i], ",");
      Record r;
      foreach(res; results) {
        string colour;
        int num;
        char space;
        // it feels like a bug that I have to capure the space
        // if I leave this as ' ' before the %d it fails at runtime
        formattedRead(res, "%c%d %s", space, num, colour);
        final switch(colour) {
          case "red":
            r.red = num;
            break;
          case "green":
            r.green = num;
            break;
          case "blue":
            r.blue = num;
            break;
        }
      }
      // add the record to this game
      game.records ~= r;
      // chop the front off the line we're looking at
      line = line[i + 1 .. line.length];
    }
    games ~= game;
  }
  // check bag case 12/13/14
  int score = 0;
  foreach(game; games) {
    bool clean = true;
    foreach(record; game.records) {
      // record is violating, mark it and move on
      if(record.red > 12 || record.green > 13 || record.blue > 14) {
        clean = false;
        break;
      }
    }
    if(clean)
      score += game.game_id;
  }
  writeln(score);
  return 0;
}
