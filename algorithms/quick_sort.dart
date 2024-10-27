/// Quick sort time complexity: O(n log n), space complexity: O(log n)
void main() {
  final List<int> list = [5, 3, 6, 2, 10];
  quickSort(list, 0, list.length - 1);
  print(list);
}

void quickSort(List<int> list, int low, int high) {
  if (low < high) {
    int pivotIndex = partition(list, low, high);

    quickSort(list, low, pivotIndex - 1);
    quickSort(list, pivotIndex + 1, high);
  }
}

int partition(List<int> list, int low, int high) {
  int pivot = list[high];
  int i = low - 1;

  for (int j = low; j < high; j++) {
    if (list[j] <= pivot) {
      i++;
      int temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }

  int temp = list[i + 1];
  list[i + 1] = list[high];
  list[high] = temp;

  return i + 1;
}
