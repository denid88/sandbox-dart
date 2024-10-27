void main() {
  final primes = sieve(100);
  print(primes);
}

List<int> sieve(int n) {
  List<bool> mark = List<bool>.filled(n + 1, true);
  List<int> primes = [];

  for (int p = 2; p * p <= n; p++) {
    if (mark[p] == true) {
      for (int i = p * p; i <= n; i += p) {
        mark[i] = false;
      }
    }
  }

  for (int p = 2; p <= n; p++) {
    if (mark[p] == true) {
      primes.add(p);
    }
  }

  return primes;
}
