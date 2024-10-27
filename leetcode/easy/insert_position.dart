/// Given a sorted array of distinct integers and a target value,
/// return the index if the target is found. If not, return the index where it
/// would be if it were inserted in order.
/// You must write an algorithm with O(log n) runtime complexity.
/// Input: nums = [1,3,5,6], target = 5
/// Output: 2

void main() {
  final s = Solution();
  final List<Input> testList = [
    Input([1, 3, 5, 6], 5),
    Input([1, 3, 5, 6], 0),
  ];
  testList.forEach((e) {
    print('result: ${s.searchInsert(e.nums, e.target)}');
  });
}

class Input {
  final List<int> nums;
  final int target;

  const Input(this.nums, this.target);
}

class Solution {
  int searchInsert(List<int> nums, int target) {
    int left = 0;
    int right = nums.length - 1;
    int mid;

    if (target < left) return 0;

    while (left <= right) {
      mid = (right - left / 2).round() + left;

      if (nums[mid] == target) {
        return mid;
      } else if (target < nums[mid]) {
        right = mid - 1;
      } else if (target > nums[mid]) {
        left = mid + 1;
      }

      if (mid == right) {
        return mid + 1;
      }
    }

    return -1;
  }
}
