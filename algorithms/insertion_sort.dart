/// InsertionSort algorithm implementation. Time Complexity: O(n^2), Space Complexity: O(1)
/// Recommended for small or almost sorted lists
void main() {
  final List<int> list = [5, 3, 6, 2, 10];
  insertionSort(list);
  print(list);
}

void insertionSort(List<int> input) {
  for (int i = 1; i < input.length; i++) {
    int key = input[i];
    int j = i - 1;

    while (j >= 0 && input[j] > key) {
      input[j + 1] = input[j];
      j--;
    }

    input[j + 1] = key;
  }
}