import 'dart:convert';
import 'package:http/http.dart' as http;

// Load json data from file server at aws
/* The default json data format as shown below
{
"appTitle": "This is the testing version ",
"baseURL": "http://laceuphk.com",
"restApiURL": "/wp-json/better-rest-endpoints/v1/",
"firstTitle": "test",
"firstTitleUrl": "posts?page=*&per_page=5&content=false",
"firstSubtitle1": "test",
"firstSubtitle2": "test",
"specialTitle": "test",
"catNumber": "214",
"specialTitleURL": "posts?category=*&content=false",
"specialSubtitle1": "test",
"specialSubtitle2": "test",
"contentURL": "post/",
"searchURL": "search?search=keyword&content=false&page=*&per_page=5"
}
*/ 

class WordpressApi {
  static String appTitle = "";
  static const String jsonURL = "https://file.shunnokw.com/link.json";

  static String baseURL;
  static String restApiURL;

  static String firstTitle;
  static String firstTitleUrl;
  static String firstSubtitle1;
  static String firstSubtitle2;

  static String specialTitle;
  static String catNumber;
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
    catNumber = linkResult["catNumber"];
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
    print("The catNumber is: " + catNumber);
    print("specialTitleURL is: " + specialTitleURL);
    print("specialSubtitle1 is: " + specialSubtitle1);
    print("specialSubtitle2 is: " + specialSubtitle2);

    print("contentURL is: " + contentURL);
    print("searchURL is: " + searchURL);
  }
}
