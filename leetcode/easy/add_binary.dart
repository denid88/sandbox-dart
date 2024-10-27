/// Given two binary strings a and b, return their sum as a binary string.
/// Input: a = "11", b = "1"
/// Output: "100"

void main() {
  final s = Solution();
  final List<Input> testList = [
    Input('11','1'),
  ];
  testList.forEach((e) {
    print('result: ${s.addBinary(e.a, e.b)}');
  });
}

class Input {
  final String a;
  final String b;
  const Input(this.a, this.b);
}

class Solution {
  String addBinary(String a, String b) {
    int p1 = a.length - 1;
    int p2 = b.length - 1;
    bool firstIsBig = a.length > b.length;
    int j = 0;
    List<int> list = [];

    while (p1 >= 0 && p2 >= 0 && j == 0) {
      int _a = p1 >= 0 ? int.tryParse(a[p1]) ?? 0 : 0;
      int _b = p2 >= 0 ? int.tryParse(b[p2]) ?? 0 : 0;

      int mod = (_a + _b) % 2;

      list.add(mod);
      if (mod == 0 && j == 0) {
        j = 1;
        list.add(0);
      }

      p1--;
      p2--;
    }

    return list.reversed.join('');
  }
}
//  11
//   1
// 100
