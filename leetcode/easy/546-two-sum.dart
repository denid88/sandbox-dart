/*
Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
You may assume that each input would have exactly one solution, and you may not use the same element twice.
You can return the answer in any order.
 */

// Input: nums = [2,7,11,15], target = 9
// Output: [0,1]
// Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

/// Two sum
List<int> twoSum(List<int> nums, int target) {
  int p1 = 0;

  while (p1 < nums.length) {
    for (int i = p1 + 1; i < nums.length; i++) {
      if (nums[p1] + nums[i] == target) {
        return [p1, i];
      }
    }
    p1++;
  }

  return [];
}

void main() {
  List<int> nums1 = [2, 7, 11, 15];
  int target1 = 9;
  print('nums: $nums1, target: $target1');
  print('result: ${twoSum(nums1, target1)}');

  List<int> nums2 = [3, 2, 4];
  int target2 = 6;
  print('nums: $nums2, target: $target2');
  print('result: ${twoSum(nums2, target2)}');

  List<int> nums3 = [3, 3];
  int target3 = 6;
  print('nums: $nums3, target: $target3');
  print('result: ${twoSum(nums3, target3)}');
}