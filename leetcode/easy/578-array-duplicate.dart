class Solution {
  bool containsDuplicate(List<int> nums) {
    return nums.toSet().length != nums.length;
  }
}

void main() {
  var sol = Solution();
  print(sol.containsDuplicate([1, 2, 3, 4])); // false
  print(sol.containsDuplicate([1, 2, 3, 1])); // true
}