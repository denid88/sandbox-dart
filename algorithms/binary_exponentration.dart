void main() {
  print(binPow(2, 10));
}

int binPow(a, n) {
  if (n == 0) return 1;
  if (n % 2 == 1) {
    return binPow(a, n - 1) * a as int;
  } else {
    int b = binPow(a, n ~/ 2);
    return b * b;
  }
}