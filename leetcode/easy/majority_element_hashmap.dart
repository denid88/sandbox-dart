//Given an array nums of size n, return the majority element.

//The majority element is the element that appears more than ⌊n / 2⌋ times.
// You may assume that the majority element always exists in the array.
void main() {
  final s = Solution();
  final List<Input> testList = [
    Input([3,2,3]),
    Input([2,2,1,1,1,2,2]),
    Input([6,5,5])
  ];
  /// Output:
  print('Output: ');
  print('---------------------------------------------------------------------');
  testList.forEach((e) {
    print('result: ${s.majorityElement(e.n)}');
  });
}


class Input {
  final List<int> n;
  const Input(this.n);
}

class Solution {
  int majorityElement(List<int> nums) {
    final Map<int, int> temp = {};
    int majorityKey = -1;
    int majorityValue = 0;

    for (var i = 0; i < nums.length; i++) {
      if (!temp.containsKey(nums[i])) {
        temp.putIfAbsent(nums[i], () => 1);
      } else {
        temp[nums[i]] = temp[nums[i]]! + 1;
      }
    }

    temp.forEach((key, value) {
      if (value > majorityValue) {
        majorityValue = value;
        majorityKey = key;
      }
    });

    return majorityKey;
  }
}