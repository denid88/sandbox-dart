//A phrase is a palindrome if, after converting all uppercase letters into
// lowercase letters and removing all non-alphanumeric characters, it reads the
// same forward and backward. Alphanumeric characters include letters
// and numbers.
// Given a string s, return true if it is a palindrome, or false otherwise.
// Input: s = "A man, a plan, a canal: Panama"
// Output: true
// Explanation: "amanaplanacanalpanama" is a palindrome.
final String case1 = 'A man, a plan, a canal: Panama';
final String case2 = 'race a car';
final String case3 = '0P';

void main() {
  final s = Solution();
  print(s.isPalindrome(case3));
}

class Solution {
  bool isPalindrome(String s) {
    String input = s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    int left = 0;
    int right = input.length - 1;

    while (left <= right) {
      if (input[left] != input[right]) {
        return false;
      }
      left++;
      right--;
    }

    return true;
  }
}