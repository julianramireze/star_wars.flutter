import 'package:star_wars/config/api.dart';

class Url {
  static String webViewGoogleSearch(String name) {
    return "${Api.getServerGoogle}search?q=${Uri.encodeComponent("${name} star wars")}";
  }
}
