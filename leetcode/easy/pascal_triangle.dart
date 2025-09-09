/// https://uk.wikipedia.org/wiki/%D0%A2%D1%80%D0%B8%D0%BA%D1%83%D1%82%D0%BD%D0%B8%D0%BA_%D0%9F%D0%B0%D1%81%D0%BA%D0%B0%D0%BB%D1%8F

List<List<int>> generatePascalTriangle(int N) {
  List<List<int>> P = [];

  for (int i = 0; i < N; i++) {
    List<int> row = List.filled(i + 1, 1);
    for (int j = 1; j < i; j++) {
      row[j] = P[i - 1][j - 1] + P[i - 1][j];
    }
    P.add(row);
  }

  return P;
}

void main() {
  int N = 7;
  var triangle = generatePascalTriangle(N);

  for (var row in triangle) {
    print(row);
  }
}