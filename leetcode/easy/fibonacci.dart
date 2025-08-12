void main() async {
  test();
}

void test() {
  expect(fibonacci(0), 0);
  expect(fibonacci(1), 1);
  expect(fibonacci(2), 1);
  expect(fibonacci(3), 2);
  expect(fibonacci(4), 3);
  expect(fibonacci(50), 12586269025);
}

void expect<T>(T a, T b) {
  if (a == b) {
    print('pass');
  } else {
    print('fail. $a != $b');
  }
}

/// The Fibonacci sequence is a series of numbers in which each number (after the first two) is the sum of the two preceding ones.
/// It typically starts with 0 and 1. The sequence goes: 0, 1, 1, 2, 3, 5, 8, 13, 21, and so forth.

/// Recursive solution
// int fibonacci(int n) {
//   if (n <= 1) {
//     return n;
//   } else {
//     return fibonacci(n - 1) + fibonacci(n - 2);
//   }
// }

/// Recursive solution with memoization
// Map<int, int> memo = {};
// int fibonacci(int n) {
//   if (n <= 1) {
//     return n;
//   }
//   if (memo.containsKey(n)) {
//     return memo[n]!;
//   }
//   memo[n] = fibonacci(n - 1) + fibonacci(n - 2);
//   return memo[n]!;
// }

/// Iterative solution
int fibonacci(int n) {
  if (n <= 1) {
    return n;
  }

  var a = 0;
  var b = 1;

  for (var i = 2; i <= n; i++) {
    int next = a + b;
    a = b;
    b = next;
  }
  return b;
}