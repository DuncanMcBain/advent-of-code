import std.algorithm.searching;
import std.algorithm;
import std.array;
import std.conv;
import std.stdio;

class FsFile {
  int size_;
  string name_;
  this(int size, string name) {
    size_ = size; name_ = name;
  }
}

class Dir {
  string name_;
  Dir parent_;
  Dir[] sub_dirs_;
  FsFile[] files_;

  this(string name, Dir parent) {
    name_ = name;
    parent_ = parent;
  }
}

void add_dir_sizes(Dir root, ref int[Dir] dir_sizes) {
  foreach(dir; root.sub_dirs_) {
    add_dir_sizes(dir, dir_sizes);
  }
  int size = root.files_.map!(a => a.size_)().sum();
  foreach(dir; root.sub_dirs_) {
    size += dir_sizes[dir];
  }
  dir_sizes[root] = size;
}

int main() {
  char[] line;
  auto f = File("day7.input", "r");
  Dir root;
  root = new Dir("/", root);
  auto cur_dir = root;
  while(f.readln(line)) {
    auto l = line.split();
    if(l[0] == "$") { // command mode
      if(l[1] == "ls") {
        continue; // start parsing from next line
      } else if(l[1] == "cd") {
        if(l[2] == "..") {
          cur_dir = cur_dir.parent_; continue;
        } else if(l[2] == "/") {
          cur_dir = root;
        } else {
          cur_dir = cur_dir.sub_dirs_.find!"a.name_ == b"(l[2]).front;
        }
      } else {
        writeln("big fail");
      }
      continue;
    }
    // if not doing commands, then listing files
    if(l[0] == "dir") {
      cur_dir.sub_dirs_ ~= new Dir(l[1].to!string(), cur_dir);
    } else {
      cur_dir.files_ ~= new FsFile(l[0].to!int(), l[1].to!string());
    }
  }
  int[Dir] dir_sizes;
  add_dir_sizes(root, dir_sizes);
  int sum = 0;
  foreach(dir; dir_sizes.byKeyValue()) {
    if(dir.value <= 100000)
      sum += dir.value;
  }
  writeln(sum);
  return 0;
}
