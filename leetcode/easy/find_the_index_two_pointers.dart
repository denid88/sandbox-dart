void main() {
  final s = Solution();
  final List<Input> testList = [
    Input('sadbutsad', 'sad'),
    Input('leetcode', 'leeto'),
    Input('hello', 'll'),
    Input('aaaaa', 'bba'),
    Input('a', 'a'),
    Input('mississippi', 'issip'),
    Input('mississippi', 'pi'),
    Input('mississippi', 'sipp'),
    Input('mississippi', 'issipi')
  ];

  /// Output:
  print('Output: ');
  print('---------------------------------------------------------------------');
  testList.forEach((e) {
    print('result: ${s.strStr(e.haystack, e.needle)}');
  });
}

class Input {
  final String haystack;
  final String needle;

  const Input(this.haystack, this.needle);
}

class Solution {
  int strStr(String haystack, String needle) {
    int left = 0;
    int right = 0;

    while (left < haystack.length) {
      if (right < needle.length && haystack[left] == needle[right]) {
        right++;
      } else {
        var temp = right;
        right = 0;
        left = left - temp;
      }

      left++;

      if (right == needle.length) {
        return left - needle.length;
      }
    }

    return -1;
  }
}