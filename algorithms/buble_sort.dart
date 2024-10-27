/// Bubble sort algorithm Time Complexity: O(n^2), Space Complexity: O(1)
void main() {
  final List<int> list = [5, 3, 6, 2, 10];
  bubbleSort(list);
  print(list);
}

void bubbleSort(List<int> input) {
  for (int j = 0; j < input.length; j++) {
    for (int i = 1; i < input.length - j; i++) {
      if (input[i] < input[i - 1]) {
        int temp = input[i];
        input[i] = input[i - 1];
        input[i - 1] = temp;
      }
    }
  }
}