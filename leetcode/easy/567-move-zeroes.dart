class Solution {
  void moveZeroes(List<int> nums) {
    int p1 = 0;

    for (int p2 = 0; p2 < nums.length; p2++) {
      if (nums[p2] != 0) {
        if (p1 != p2) {
          int temp = nums[p1];
          nums[p1] = nums[p2];
          nums[p2] = temp;
        }
        p1++;
      }
    }
  }
}

void main() {
  var arr = [0, 1, 0, 3, 12];
  var arr2 = [1, 0, 1];
  Solution().moveZeroes(arr);
  print(arr); // [1, 3, 12, 0, 0]
  Solution().moveZeroes(arr2);
  print(arr2); // [1, 1, 0]
}