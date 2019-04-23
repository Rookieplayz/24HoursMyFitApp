
import 'dart:math';

class UsernameGenerator {
  String createUsername() {
    String pattern = '[A-Za-z]+';
  }

  bool searchForVowels(String word) {
    word = word.toLowerCase();
    int found = 0;
    var vowels = ['a', 'e', 'i', 'o', 'u'];
    for (String v in vowels) {
      for (int i = 0; i < word.length - 1; i++) {
        if (word.substring(i, i + 1) == v) {
          found++;
        }
      }
    }

    if (found >= 1)
      return true;
    else
      return false;
  }

  String getUsername() {
    String username = "";
    username = username.toLowerCase();
    var alphabets = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z'
    ];
    int alphapick = 0;
    int generatedLength = 0;
    while (!(searchForVowels(username) &&
        (searchForConsonants(username)) &&
        checkWordEfficiency(username))) {
      generatedLength = rndNumber(2, 5);
      username = "";
      for (int i = 0; i < generatedLength; i++) {
        alphapick = rndNumber(0, alphabets.length - 1);

        username += alphabets[alphapick];
      }
      print("Username: $username");
    }
    return insertNumber(username);
  }

  String insertNumber(String name) {
    int pos = rndNumber(0, name.length - 1);
    int randNumber = rndNumber(0, 20000);
    String finalUsername = name;
    if (randNumber < 60) {
      finalUsername =
          finalUsername.replaceRange(pos, pos + 1, randNumber.toString());
    } else {
      finalUsername += randNumber.toString();
    }
    String username = finalUsername;
    print("username $randNumber");
    username =
        username.replaceRange(0, 1, username.substring(0, 1).toUpperCase());
    return username;
  }

  String charAt(String word, int index) {
    word += "a";
    return word.substring(index, index + 1);
  }

  bool checkWordEfficiency(String word) {
    int efficent = 0;
    String vowels = "a|e|i|o|u"; // not r'/api/\w+/\d+/' !!!
    String consonants = "b|c|d|f|g|h|j|k|l|m|n|p|q|r|s|t|v|w|x|y|z";
    for (int i = 0; i < word.length; i++) {
      for (int j = 0; j < word.length; j++) {
        if (charAt(word, i).contains(vowels)) {
          if (charAt(word, j) == charAt(word, i)) {
            efficent -= 10;
          } else if (searchForVowels(charAt(word, j))) {
            efficent -= 50;
          } else
            efficent += 50;
        } else {
          if (charAt(word, j) == charAt(word, i)) {
            efficent -= 10;
          } else if (searchForConsonants(charAt(word, j))) {
            efficent -= 50;
          } else
            efficent += 50;
        }
      }
    }
    print("Effieciency: " + efficent.toString() + "%");
    if (efficent <= 100)
      return false;
    else
      return true;
  }

  num rndNumber(num min, num max) {
    return new Random().nextInt(max - min + 1) + min;
  }

  bool searchForConsonants(String word) {
    word = word.toLowerCase();
    int found = 0;
    var cons = [
      'b',
      'c',
      'd',
      'f',
      'g',
      'h',
      'j',
      'k',
      'l',
      'm',
      'n',
      'p',
      'q',
      'r',
      's',
      't',
      'v',
      'w',
      'x',
      'y',
      'z'
    ];
    for (String c in cons) {
      for (int i = 0; i < word.length - 1; i++) {
        if (word.substring(i, i + 1) == c) {
          found++;
        }
      }
    }

    if (found >= 1)
      return true;
    else
      return false;
  }
}