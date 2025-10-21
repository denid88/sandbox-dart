void main() {
  print(reverse(123));     // 321
  print(reverse(-123));    // -321
  print(reverse(120));     // 21
  print(reverse(1534236469)); // 0 (переповнення)
}

int reverse(int x) {
  bool isPositive = x >= 0;
  String reversed = x.abs().toString().split('').reversed.join();
  int result = int.parse(reversed);

  if (!isPositive) result = -result;

  const int int32Min = -2147483648;
  const int int32Max = 2147483647;

  return (result >= int32Min && result <= int32Max) ? result : 0;
}