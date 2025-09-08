/// 67. Add Binary
/// Given two binary strings a and b, return their sum as a binary string.
/// Input: a = "11", b = "1"
/// Output: "100"

class Solution {
  String addBinary(String a, String b) {
    String result = "";
    List<String> array1 = a.split('');
    List<String> array2 = b.split('');
    int p1 = array1.length - 1;
    int p2 = array2.length - 1;
    int carry = 0;

    while (p1 >= 0 || p2 >= 0 || carry > 0) {
      int x = p1 >= 0 ? int.parse(array1[p1]) : 0;
      int y = p2 >= 0 ? int.parse(array2[p2]) : 0;

      int sum = x + y + carry;
      result = (sum % 2).toString() + result;
      carry = sum ~/ 2;

      p1--;
      p2--;
    }

    return result;
  }
}

void main() {
  var sol = Solution();
  print(sol.addBinary("1010", "1011")); // виведе 10101
}