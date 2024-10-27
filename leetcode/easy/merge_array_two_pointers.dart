/// You are given two integer arrays nums1 and nums2, sorted in non-decreasing
/// order, and two integers m and n, representing the number of elements in
/// nums1 and nums2 respectively.
/// Merge nums1 and nums2 into a single array sorted in non-decreasing order.
/// The final sorted array should not be returned by the function, but
/// be stored inside the array nums1. To accommodate this, nums1 has a
/// length of m + n, where the first m elements denote the elements that should
/// be merged, and the last n elements are set to 0 and should be ignored.
/// nums2 has a length of n.

void main() {
  final s = Solution();
  // ///Case 1
  // final list1 = [1,2,3,0,0,0];
  // final target1 = 3;
  // final list2 = [2,5,6];
  // final target2 = 3;
  // ///Case 2
  // final list1 = [0];
  // final target1 = 0;
  // final list2 = [1];
  // final target2 = 1;
  // ///Case 3
  // final list1 = [4,5,6,0,0,0];
  // final target1 = 3;
  // final list2 = [1,2,3];
  // final target2 = 3;
  /// Case4
  final list1 = [4,0,0,0,0,0];
  final target1 = 1;
  final list2 = [1,2,3,5,6];
  final target2 = 5;
  // /// Case5
  // final list1 = [1,2,4,5,6,0];
  // final target1 = 5;
  // final list2 = [3];
  // final target2 = 1;

  s.merge(list1, target1, list2, target2);
}

class Solution {
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    int i = m - 1;
    int j = n - 1;
    int k = m + n - 1;
    int d = 0;

    while (j >= 0) {
      print('__iteration__$d');
      print(i);
      print(j);
      print(k);

      if (i >= 0 && nums1[i] > nums2[j]) {
        nums1[k--] = nums1[i--];
      } else {
        nums1[k--] = nums2[j--];
      }

      d++;
    }
  }
}