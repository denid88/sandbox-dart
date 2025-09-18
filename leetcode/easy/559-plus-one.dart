// You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's.
//
// Increment the large integer by one and return the resulting array of digits.

// Input: digits = [1,2,3]
// Output: [1,2,4]
// Explanation: The array represents the integer 123.
// Incrementing by one gives 123 + 1 = 124.
// Thus, the result should be [1,2,4].

void main() {
  List<int> digits = [9, 9, 9];
  List<int> result = plusOne(digits);
  print(result); // [1, 0, 0, 0]
}

List<int> plusOne(List<int> digits) {
  int carry = 1;

  for (int i = digits.length - 1; i >= 0; i--) {
    int sum = digits[i] + carry;
    digits[i] = sum % 10;
    carry = sum ~/ 10;
  }

  if (carry > 0) {
    digits.insert(0, carry);
  }

  return digits;
}