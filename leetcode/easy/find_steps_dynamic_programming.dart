void main() {
  final s = Solution();
  final List<Input> testList = [
    Input(2),
    Input(44)
  ];
  /// Output:
  print('Output: ');
  print('---------------------------------------------------------------------');
  testList.forEach((e) {
    print('result: ${s.climbStairs(e.n)}');
  });
}

class Input {
  final int n;
  const Input(this.n);
}

class Solution {
  int climbStairs(int n) {
    if(n == 1) return 1;
    if(n == 2) return 2;
    List<int> availableCombinations = [0,1,2];
    for(int i = 3; i <= n; i++) {
      availableCombinations.add(
        availableCombinations[i-1] + availableCombinations[i-2]
      );
    }
    print(availableCombinations);
    return availableCombinations[n];
  }
}