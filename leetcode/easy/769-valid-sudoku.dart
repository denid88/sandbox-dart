bool isValidSudoku(List<List<String>> board) {
  List<Set<String>> rows = List.generate(9, (_) => <String>{});
  List<Set<String>> cols = List.generate(9, (_) => <String>{});
  List<Set<String>> boxes = List.generate(9, (_) => <String>{});

  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      String val = board[i][j];
      if (val == '.') continue;

      int boxIndex = (i ~/ 3) * 3 + (j ~/ 3);

      if (rows[i].contains(val) ||
          cols[j].contains(val) ||
          boxes[boxIndex].contains(val)) {
        return false;
      }

      rows[i].add(val);
      cols[j].add(val);
      boxes[boxIndex].add(val);
    }
  }
  return true;
}

void main() {
  List<List<String>> board = [
    ['5','3','.','.','7','.','.','.','.'],
    ['6','.','.','1','9','5','.','.','.'],
    ['.','9','8','.','.','.','.','6','.'],
    ['8','.','.','.','6','.','.','.','3'],
    ['4','.','.','8','.','3','.','.','1'],
    ['7','.','.','.','2','.','.','.','6'],
    ['.','6','.','.','.','.','2','8','.'],
    ['.','.','.','4','1','9','.','.','5'],
    ['.','.','.','.','8','.','.','7','9'],
  ];

  bool result = isValidSudoku(board);
  print(result ? "✅ Sudoku board is valid" : "❌ Sudoku board is invalid");
}
