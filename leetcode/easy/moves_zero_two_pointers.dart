void main() {
  final s = Solution();
  final List<Input> testList = [
   Input([0,1,0,3,12]),
   Input([0]),
   Input([1,0,1]),
   Input([4,2,4,0,0,3,0,5,1,0]),
   Input([2,1]),
   Input([0,0,1]),
  ];

  /// Output:
  print('Output: ');
  print('---------------------------------------------------------------------');
  testList.forEach((e) {
    s.moveZeroes(e.value);
    print(e.value);
  });
}

class Input {
  final List<int> value;
  const Input(this.value);
}

class Solution {
  void moveZeroes(List<int> nums) {
    int nonZeroIndex = 0;

    for (int i = 0; i < nums.length; i++) {
      if (nums[i] != 0) {
        nums[nonZeroIndex] = nums[i];
        nonZeroIndex++;
      }
    }

    for (int i = nonZeroIndex; i < nums.length; i++) {
      nums[i] = 0;
    }
  }
}