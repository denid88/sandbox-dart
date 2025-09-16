// Single Number
//
// Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.
// You must implement a solution with a linear runtime complexity and use only constant extra space.
//
// Input: nums = [2,2,1]
// Output: 1

//List: [4, 1, 2, 1, 2]
// result = 0
// result ^= 4   -> 4
// result ^= 1   -> 5   (бо 100 ^ 001 = 101)
// result ^= 2   -> 7   (101 ^ 010 = 111)
// result ^= 1   -> 6   (111 ^ 001 = 110)
// result ^= 2   -> 4   (110 ^ 010 = 100)

class Solution {
  int singleNumber(List<int> nums) {
    var result = 0;
    for (var n in nums) {
      result ^= n;
    }
    return result;
  }
}

void main() {
  final s = Solution();

  final tests = <List<int>>[
    [2, 2, 1],           // -> 1
    [4, 1, 2, 1, 2],     // -> 4
    [7],                 // -> 7
    [0, 1, 0],           // -> 1
  ];

  for (var t in tests) {
    final res = s.singleNumber(t);
    print('nums: $t  => result: $res');
  }
}