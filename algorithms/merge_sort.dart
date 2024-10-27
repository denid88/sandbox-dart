/// O(n log n) time complexity sorting algorithm, memory complexity O(n)
void main() {
  final List<int> list = [12, 5, 3, 6, 2, 10];
  final List<int> mergeSortedList = mergeSort(list);
  print(mergeSortedList);
}

List<int> mergeSort(List<int> list) {
  if (list.length <= 1) return list;

  int mid = list.length ~/ 2;
  List<int> left = [];
  List<int> right = [];

  for (int i = 0; i < mid; i++) {
    left.add(list[i]);
  }

  for (int i = mid; i < list.length; i++) {
    right.add(list[i]);
  }

  left = mergeSort(left);
  right = mergeSort(right);

  return merge(left, right);
}

List<int> merge(List<int> left, List<int> right) {
  List<int> merged = [];
  int left_index = 0;
  int right_index = 0;

  while(left_index < left.length && right_index < right.length) {
    if (left[left_index] <= right[right_index]) {
      merged.add(left[left_index]);
      left_index++;
    } else {
      merged.add(right[right_index]);
      right_index++;
    }
  }

  while(left_index < left.length) {
    merged.add(left[left_index]);
    left_index++;
  }

  while(right_index < right.length) {
    merged.add(right[right_index]);
    right_index++;
  }

  return merged;
}