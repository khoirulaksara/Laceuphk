import 'dart:convert';
import 'package:http/http.dart' as http;

class Strings {
  static const String appTitle = "LaceupHK";
  static String baseURL =
      "http://laceuphk.com/wp-json/better-rest-endpoints/v1/";

  static String dataUrl = baseURL + "posts?content=false";
  static String contentURL = baseURL + "post/";
  static String shoesReviewURL =
      baseURL + "posts?category=63&content=false";
  static String searchURL = baseURL + "search?search=";

  static loadURL() async {
    http.Response response =
        await http.get("http://18.140.232.162:8080/link.json");
    final linkResult = jsonDecode(response.body);
    baseURL = linkResult[baseURL];
  }
}
