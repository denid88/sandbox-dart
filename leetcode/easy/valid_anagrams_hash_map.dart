//Given two strings s and t, return true if t is an anagram of s,
// and false otherwise.
// An Anagram is a word or phrase formed by rearranging the letters of a
// different word or phrase, typically using all the original letters
// exactly once.

void main() {
  final s = Solution();
  //var a = "anagram", b = "nagaram";
  //var a = "rat", b = "car";
  var a = "a", b = "ab";
  print(s.isAnagram(a, b));
}

class Solution {
  bool isAnagram(String s, String t) {
    final Map<String, int> hash = {};
    bool result = true;

    for (var i = 0; i < s.length; i++) {
      if (hash.containsKey(s[i])) {
        hash[s[i]] = hash[s[i]]! + 1;
      } else {
        hash[s[i]] = 1;
      }
    }

    for (var i = 0; i < t.length; i++) {
      if (hash.containsKey(t[i])) {
        hash[t[i]] = hash[t[i]]! - 1;
      } else {
        hash[t[i]] = 1;
      }
    }

    for (var key in hash.keys) {
      if (hash[key] != 0) {
        result = false;
      }
    }

    return result;
  }
}