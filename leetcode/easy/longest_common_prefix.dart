///Write a function to find the longest common prefix string amongst an array
/// of strings.If there is no common prefix, return an empty string "".
///
/// Input: strs = ["flower","flow","flight"]
/// Output: "fl"

void main() {
  final s = Solution();
  final List<Input> testList = [
    Input(["flower", "flow", "flight"]),
    Input(["dog", "racecar", "car"]),
    Input([""]),
    Input(["a"])
  ];
  testList.forEach((e) {
    print('result: ${s.longestCommonPrefix(e.text)}');
  });
}

class Input {
  final List<String> text;
  const Input(this.text);
}

class Solution {
  String longestCommonPrefix(List<String> strs) {
    String match = '';
    String char = '';
    int j = 0;
    bool isLooped = true;

    while (isLooped) {
      for (var i = 0; i < strs.length; i++) {
        if (char.isEmpty && j < strs[i].length) {
          char = strs[i][j];
        }

        if (strs[i].isEmpty ||
            j == strs[i].length ||
            (j < strs[i].length && char != strs[i][j])) {
          char = '';
          isLooped = false;
          break;
        }
      }

      match += char;
      char = '';
      j++;
    }

    return match;
  }
}
