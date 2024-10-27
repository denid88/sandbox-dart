/// Counting sort algorithm implementation. Time Complexity: O(n+m), Space Complexity: O(n+m)
void main() {
  final List<int> list = [5, 3, 6, 2, 10];
  countingSort(list);
  print(list);
}

void countingSort(List<int> input) {
  int min = input[0];
  int max = input[0];

  for (var i = 0; i < input.length; i++) {
    if (input[i] < min) {
      min = input[i];
    } else if (input[i] > max) {
      max = input[i];
    }
  }

  final List<int> bucket = List<int>.filled(max - min + 1, 0);


  for (var i = 0; i < input.length; i++) {
    bucket[input[i] - min]++;
  }

  input.clear();

  for (var i = 0; i < bucket.length; i++) {
    int count = bucket[i];
    for (int j = 0; j < count; j++) {
      input.add(i + min);
    }
  }
}