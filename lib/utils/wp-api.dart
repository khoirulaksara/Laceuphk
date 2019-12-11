import 'dart:convert';
import 'package:http/http.dart' as http;

class WordpressApi {
  static String appTitle = "";
  static const String jsonURL = "http://18.140.232.162:8080/link.json";

  static String baseURL;
  static String restApiURL;

  static String firstTitle;
  static String firstTitleUrl;
  static String firstSubtitle1;
  static String firstSubtitle2;

  static String specialTitle;
  static String specialTitleURL;
  static String specialSubtitle1;
  static String specialSubtitle2;

  static String contentURL;
  static String searchURL;

  static loadURL() async {
    http.Response response =
        await http.get(jsonURL);
    final linkResult = jsonDecode(response.body);

    appTitle = linkResult["appTitle"];
    baseURL = linkResult["baseURL"];
    restApiURL = linkResult["restApiURL"];

    firstTitle = linkResult["firstTitle"];
    firstTitleUrl = baseURL + restApiURL +linkResult["firstTitleUrl"];
    firstSubtitle1 = linkResult["firstSubtitle1"];
    firstSubtitle2 = linkResult["firstSubtitle2"];
   
    specialTitle = linkResult["specialTitle"];
    specialTitleURL = baseURL + restApiURL + linkResult["specialTitleURL"];
    specialSubtitle1 = linkResult["specialSubtitle1"];
    specialSubtitle2 = linkResult["specialSubtitle1"];

    contentURL = baseURL + restApiURL + linkResult["contentURL"];
    searchURL = baseURL + restApiURL + linkResult["searchURL"];

    print("baseURL is: " + baseURL);
    print("restApiURL is: " + restApiURL);

    print("firstTitle is: " + firstTitle);
    print("firstTitleUrl is: " + firstTitleUrl);
    print("firstSubtitle1 is: " + firstSubtitle1);
    print("firstSubtitle2 is: " + firstSubtitle2);

    print("specialTitle is: " + specialTitle);
    print("specialTitleURL is: " + specialTitleURL);
    print("specialSubtitle1 is: " + specialSubtitle1);
    print("specialSubtitle2 is: " + specialSubtitle2);

    print("contentURL is: " + contentURL);
    print("searchURL is: " + searchURL);
  }
}
