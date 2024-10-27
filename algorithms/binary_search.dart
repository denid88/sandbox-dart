/// Time Complexity: O(log n), Space Complexity: O(1)
void main() {
  final List<int> input = [-1, 2, 3, 4, 10, 33, 65, 100];
  final int target = 65;
  final int output = binarySearch(input, target);
  print('input: [-1, 2, 3, 4, 10, 33, 65, 100]');
  print('target: 65');
  print('output: $output');
}

int binarySearch(List<int> input, int target) {
  int left = 0;
  int right = input.length - 1;
  int mid;

  while (left <= right) {
    mid = (right - left / 2).round() + left;

    if (input[mid] == target) {
      return mid;
    } else if (target < input[mid]) {
      right = mid - 1;
    } else if (target > input[mid]) {
      left = mid + 1;
    }
  }

  return -1;
}