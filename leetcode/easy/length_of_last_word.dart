///Given a string s consisting of words and spaces, return the length
/// of the last word in the string.
///A word is a maximal
///substring consisting of non-space characters only.

void main() {
  final s = Solution();
  final List<Input> testList = [
    Input('Hello World'),
    Input('   fly me   to   the moon  '),
    Input('luffy is still joyboy'),
    Input('a'),
    Input('a '),
    Input('Day')
  ];
  testList.forEach((e) {
    print('result: ${s.lengthOfLastWord(e.text)}');
  });
}

class Input {
  final String text;
  const Input(this.text);
}

class Solution {
  int lengthOfLastWord(String s) {
    int i = s.length - 1;
    int r = 0;
    int l = 0;

    while (i >= 0) {
      if (s[i] != ' ' && r == 0) {
        r = i + 1;
      }
      if (l == 0 && s[i] == ' ' && r != 0) {
        l = i + 1;
      }
      i--;
    }

    return r - l;
  }
}
