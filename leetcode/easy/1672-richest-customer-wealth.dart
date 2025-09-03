/*
You are given an m x n integer grid accounts where accounts[i][j] is the amount
 of money the customer has in the bank. Return the wealth that the richest customer has.

A customer's wealth is the amount of money they have in all their bank accounts.
The richest customer is the customer that has the maximum wealth.
 */

// Input: accounts = [[1,2,3],[3,2,1]]
// Output: 6
// Explanation:
// 1st customer has wealth = 1 + 2 + 3 = 6
// 2nd customer has wealth = 3 + 2 + 1 = 6
// Both customers are considered the richest with a wealth of 6 each, so return 6.

void main() {
  List<List<int>> accounts = [
    [1, 2, 3],
    [3, 2, 1],
    [5, 1, 2]
  ];

  int result = maximumWealth(accounts);
  print("Maximum wealth: $result");
}

int maximumWealth(List<List<int>> accounts) {
  int maxWealth = 0;

  for (int i = 0; i < accounts.length; i++) {
    int sum = 0;
    for (int j = 0; j < accounts[i].length; j++) {
      sum += accounts[i][j];
    }
    if (sum > maxWealth) {
      maxWealth = sum;
    }
  }

  return maxWealth;
}