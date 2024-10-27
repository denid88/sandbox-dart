/// You are given a large integer represented as an integer array digits,
/// where each digits[i] is the ith digit of the integer. The digits are ordered
/// from most significant to least significant in left-to-right order. The large
/// integer does not contain any leading 0's.

/// Increment the large integer by one and return the resulting array of digits.
/// Input: digits = [1,2,3]
/// Output: [1,2,4]
/// Explanation: The array represents the integer 123.
/// Incrementing by one gives 123 + 1 = 124.
/// Thus, the result should be [1,2,4].

void main() {
  final s = Solution();
  final List<Input> testList = [
    Input([1, 2, 3]),
    Input([9]),
    Input([9, 9]),
  ];
  testList.forEach((e) {
    print('result: ${s.addOne(e.value)}');
  });
}

class Input {
  final List<int> value;
  const Input(this.value);
}

class Solution {
  List<int> addOne(List<int> digits) {
    int j = 0;
    var result = <int>[];
    bool openAdd = true;

    for (var i = digits.length - 1; i >= 0; i--) {
      var num = openAdd ? digits[i] + 1 : digits[i];

      if (num > 9) {
        j = 1;
      } else {
        j = 0;
        openAdd = false;
      }

      if (j == 1) {
        result.add(0);
      } else {
        result.add(num);
      }
    }

    if (j == 1) {
      result.add(j);
    }

    return result.reversed.toList();
  }
}
