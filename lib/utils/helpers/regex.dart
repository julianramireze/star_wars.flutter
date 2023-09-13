class Regex {
  static String? getID(String url) {
    RegExp regExp = RegExp(r'(\d+)\/?$');
    Match? match = regExp.firstMatch(url);
    if (match != null) {
      return match.group(1);
    }
    return null;
  }
}
