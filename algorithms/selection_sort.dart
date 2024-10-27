/// Selection Sort complexity O(n^2), Space Complexity: O(1)
void main() {
  final List<int> list = [5, 3, 6, 2, 10];
  selectionSort(list);
  print(list);
}

void selectionSort(List<int> input) {
  int minIndex = 0;
  int temp = 0;

  for (var j = 0; j < input.length; j++) {

    minIndex = j;

    for (var i = j + 1; i < input.length; i++) {
      if (input[minIndex] > input[i]) {
        minIndex = i;
      }
    }

    temp = input[j];
    input[j] = input[minIndex];
    input[minIndex] = temp;
  }
}