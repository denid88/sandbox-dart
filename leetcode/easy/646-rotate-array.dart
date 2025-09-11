class Solution {
  void rotate(List<int> nums, int k) {
    int n = nums.length;
    int shift = k % n;
    List<int> result = List.filled(n, 0);

    for (int i = 0; i < n; i++) {
      int newIndex = (i + shift) % n;
      result[newIndex] = nums[i];
    }

    for (int i = 0; i < n; i++) {
      nums[i] = result[i];
    }
  }
}

void main() {
  List<int> nums = [1, 2, 3, 4, 5, 6, 7];
  int k = 3;

  Solution().rotate(nums, k);

  print(nums); // [5, 6, 7, 1, 2, 3, 4]
}