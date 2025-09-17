// Intersection of Two Arrays II
//
// Given two integer arrays nums1 and nums2, return an array of their intersection. Each element in the result must appear as many times as it shows in both arrays and you may return the result in any order.
//
// Input: nums1 = [1,2,2,1], nums2 = [2,2]
// Output: [2,2]

class Solution {
  List<int> intersect(List<int> nums1, List<int> nums2) {
    final Map<int, int> counts = {};
    final List<int> result = [];

    for (var num in nums1) {
      counts[num] = (counts[num] ?? 0) + 1;
    }

    for (var num in nums2) {
      final count = counts[num] ?? 0;
      if (count > 0) {
        result.add(num);
        counts[num] = count - 1;
      }
    }

    return result;
  }
}

void main() {
  final solution = Solution();

  print(solution.intersect([1, 2, 2, 1], [2, 2])); // [2, 2]
  print(solution.intersect([4, 9, 5], [9, 4, 9, 8, 4])); // [9, 4] або [4, 9]
}