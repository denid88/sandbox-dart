/// Time Complexity: O(log(min(a, b)))
/// Коли найбільший спільник дільник двох чисел a та b дорівнює 1,
/// то числа a та b називаються взаємно простими.
void main() {
  print(gcd(10, 15));
  print(lcm(3, 5));
}

int gcd(int a, int b) {
  return b != 0 ? gcd(b, a % b) : a;
}

int lcm (int a, int b) {
  return (a / gcd(a, b) * b).toInt();
}