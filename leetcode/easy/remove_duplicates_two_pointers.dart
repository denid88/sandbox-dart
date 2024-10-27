/// Given an integer array nums sorted in non-decreasing order, remove the
/// duplicates in-place such that each unique element appears only once.
/// The relative order of the elements should be kept the same. Then return
/// the number of unique elements in nums.
/// Consider the number of unique elements of nums to be k, to get accepted,
/// you need to do the following things:
/// Change the array nums such that the first k elements of nums contain the
/// unique elements in the order they were present in nums initially.
/// The remaining elements of nums are not important as well as the size of nums.
/// Return k.
/// Input: nums = [1,1,2]
/// Output: 2, nums = [1,2,_]
void main() {
  final s = Solution();
  final case1 = [1,1,2];
  final case2 = [0,0,1,1,1,2,2,3,3,4];
  final case3 = [1];
  final case4 = [1,1];
  s.removeDuplicates(case4);
}

class Solution {
  int removeDuplicates(List<int> nums) {
    int left = 0;
    int k = 0;

    while (k < nums.length) {

      if (nums[left] < nums[k]) {
        nums[left + 1] = nums[k];
        left++;
      } else {
        nums[left] = nums[k];
      }
      k++;
    }

    return left + 1;
  }
}