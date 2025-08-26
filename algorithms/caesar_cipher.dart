//
// This is a more algorithmic way of solving the Caesar Cipher using the following equations
//
// E(x) = (x + n) mod 26
// D(x) = (x - n) mod 26
//
// x = letter
// n = offset

// What these equations basically say is, you can take any given letter, shift it by it's offset, and then
// modulus 26 that result (25 letters in the alphabet).
//
// By applying this equation, we can come up with a more generic cipher algorithm, that encrypts and decrypts
// for any generic offset (n).
//
// https://en.wikipedia.org/wiki/Caesar_cipher

// Assumption: Upper case only

void main() {
  final String text = "HELLO WORLD";
  final int offset = 3;

  final String encrypted = CaesarCipher.encrypt(text: text, offset: offset);
  print("Encrypted: $encrypted");

  final String decrypted = CaesarCipher.decrypt(text: encrypted, offset: offset);
  print("Decrypted: $decrypted");
}

class CaesarCipher {

  static const ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  static String encrypt({String text = '', int offset = 3}) {
    var result = [];
    List charsToEncrypt = text.split('');
    List lookupMap = ALPHABET.split('');

    for (final charToEncrypt in charsToEncrypt) {
      String encryptedChar = " ";
      if (charToEncrypt != " ") {
        int x = lookupMap.indexOf(charToEncrypt);
        int key = (offset + x) % 26;
        encryptedChar = lookupMap[key];
      }
      result.add(encryptedChar);
    }

    return result.join();
  }

  static String decrypt({String text = '', int offset = 3}) {
    var result = [];
    List charsToEncrypt = text.split('');
    List lookupMap = ALPHABET.split('');

    for (final charToEncrypt in charsToEncrypt) {
      String encryptedChar = " ";
      if (charToEncrypt != " ") {
        int x = lookupMap.indexOf(charToEncrypt);
        int key = (x - offset) % 26;
        encryptedChar = lookupMap[key];
      }
      result.add(encryptedChar);
    }

    return result.join();
  }
}