// Input: nums = [3,2,2,3], val = 3
// Output: 2, nums = [2,2,_,_]
// Explanation: Your function should return k = 2, with the first two elements of nums being 2.
// It does not matter what you leave beyond the returned k (hence they are underscores).
void main() {
  final s = Solution();
  //final nums = [3,2,2,3], val = 3;
  final nums = [0,1,2,2,3,0,4,2], val = 2;
  s.removeElement(nums, val);
}

class Solution {
  int removeElement(List<int> nums, int val) {
    int left = 0;
    int k = 0;

    while (k < nums.length) {
      if (nums[k] != val) {
        nums[left] = nums[k];
        left++;
      }
      k++;
    }

    return left + 1;
  }
}
