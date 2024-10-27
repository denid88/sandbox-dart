void main() {}

/// Complexity O(n) = constant * n
int search (List<int> a, int x) {
  for (var i = 0; i < a.length; i++) {
    if (a[i] == x) {
      return i;
    }
  }
  return -1;
}
/// Complexity O(1) = constant
void swap(int a, int b) {
  var t = a;
  a = b;
  b = t;
}
/// Complexity O(1)
void cycleExampleO1() {
  final c = 4;
  for (var i = 0; i < c; i++) {
    print(i);
  }
}
/// Complexity O(n)
void cycleExampleOn(int n) {
  for (var i = 0; i < n; i++) {
    print(i);
  }
}
/// Complexity O(n + m)
void cycleExampleNM(int n, int m) {
  for (var i = 0; i < n; i++) {
    print(i);
  }
  for (var i = 0; i < m; i++) {
    print(i);
  }
}

/// Complexity O(n * m)
void cycleExampleNM2(int n, int m) {
  for (var i = 0; i < n; i++)
    for (var j = 0; j < m; j++)
      print(i);
}

/// Complexity O(n^2)
void cycleExampleN2(int n) {
  for (var i = 0; i < n; i++)
    for (var j = 0; j < n; j++)
      print(i);
}

/// Complexity O(n^3)
void cycleExampleN3(int n) {
  for (var i = 0; i < n; i++)
    for (var j = 0; j < n; j++)
      for (var k = 0; k < n; k++)
        print(i);
}

/// Complexity O(n^3)
void cycleExampleIJ(int n) {
  for (var i = 0; i < n; i++)
    for (var j = i; j < n; j++)
      print(i + j);
}

/// Complexity O(n^3 + n^2 + n) = O(n^3)
void cycleExample123(int n) {
  for (var i = 0; i < n; i++)
    for (var j = 0; j < n; j++)
      for (var k = 0; k < n; k++)
        print(i);

  for (var i = 0; i < n; i++)
    for (var j = 0; j < n; j++)
      print(i);

  for (var i = 0; i < n; i++)
    print(i);
}

/// Complexity O(a^3 + b^2 + c)
void cycleExample1234(int a, int b, int c) {
  for (var i = 0; i < a; i++)
    for (var j = 0; j < a; j++)
      for (var k = 0; k < a; k++)
        print(i);

  for (var i = 0; i < b; i++)
    for (var j = 0; j < b; j++)
      print(i);

  for (var i = 0; i < c; i++)
    print(i);
}

/// Complexity O(log(n))
int cycleExampleLog(int a) {
  int sum = 0;
  while (a != 0) {
    sum += a % 10;
    a / 10;
  }
  return sum;
}
/// Complexity O(n * log(n))
int cycleExampleLogN(int n) {
  int sum = 0;
  for (var i = 0; i < n; i++) {
    int a = i;
    while (a != 0) {
      sum += a % 10;
      a / 10;
    }
  }
  return sum;
}
/// Complexity O(sqrt(n))
void cycleExampleSqrt(int n) {
  for (var i = 0; i * i < n; i++) {
    print(i);
  }
}

/// Complexity O(n)
void cycleExampleNPlus2(int n) {
  for (var i = 0; i < n; i += 2) { /// n / 2 = 1/2 * n
    print(i);
  }
}

/// Complexity O(2^n), O(3^n), O(n!)
/// 10^9 