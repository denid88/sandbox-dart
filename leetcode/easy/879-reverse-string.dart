void main() {
  List<String> s = ['h', 'e', 'l', 'l', 'o'];
  reverseString(s);
  print(s); // [o, l, l, e, h]
}

void reverseString(List<String> s) {
  int left = 0;
  int right = s.length - 1;

  while (left < right) {
    final temp = s[left];
    s[left] = s[right];
    s[right] = temp;
    left++;
    right--;
  }
}
