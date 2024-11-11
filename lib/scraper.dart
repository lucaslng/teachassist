import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:teachassist/course.dart';
import 'package:teachassist/tools/debug.dart';
// import 'package:teachassist/tools/debug.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

class Scraper {
  final HttpClient _client = HttpClient();
  String id = "";
  String password = "";
  Scraper(this.id, this.password);
  
  final CookieJar _cookieJar = CookieJar();
  
  Future<HttpClientResponse> _makeRequest(Uri uri) async {
    
    var request = await _client.getUrl(uri);
    request.cookies.addAll(await _cookieJar.loadForRequest(uri));
    request.followRedirects = false;
    HttpClientResponse response = await request.close();
    _cookieJar.saveFromResponse(uri, response.cookies);

    // debug("\n");
    // debug("connecting to $uri");
    // debug(response.statusCode);
    // debug(response.headers);
    // debug("\n");
    
    if (response.isRedirect) {
      Uri location = Uri.parse(response.headers.value(HttpHeaders.locationHeader)!);

      if (location == Uri.parse("https://ta.yrdsb.ca/live/index.php?error_message=3")) {
        return Future.error("Invalid login");
      } else {
        // debug("\nredirecting to $location \n");
        return _makeRequest(location);
      }
      
    } else {
      return response;
    }
    
  }

  Future<List<Course>> fetchData() async {
    final uri = Uri.https(
      'ta.yrdsb.ca',
      'live/index.php',
      {"username": id, "password": password, "submit": "Login", "subject_id": "0"},
    );

    HttpClientResponse response = await _makeRequest(uri);
    if (response.statusCode == 200) {
      final Future<String> responseBody = response.transform(utf8.decoder).join();
      
      return _parseData(await responseBody);
    } else {
      return Future.error(Exception("error: ${response.statusCode}"));
    }
  }

  List<Course> _parseData(String data) {
    List<Course> courses = [];

    final HtmlDocument doc = parseHtmlDocument(data);

    final List<Element> coursesElements = doc.querySelector('body > div > div:nth-child(2) > div > table > tbody')!.children.toList();
    coursesElements.removeRange(0, 1);
    
    for (var courseElement in coursesElements) {

      var subjectAndBlock = courseElement.querySelector('td:nth-child(1)')!.innerHtml!.split("<br>");
      var subject = subjectAndBlock[0].split(" :");
      var code = subject[0].trim();
      var name = subject[1].trim();
      var block = subjectAndBlock[1].split(" - ");
      var period = block[0].replaceFirst("Block: P", "").trim();
      var room = block[1].replaceFirst("rm. ", "").trim();

      var date = courseElement.querySelector('td:nth-child(2)')!.innerHtml!.split(" ~");
      var startDateString = date[0].trim();
      var endDateString = date[1].trim();
      List<String> startDateList = startDateString.split("-");
      DateTime startDate = DateTime(int.parse(startDateList[0]), int.parse(startDateList[1]), int.parse(startDateList[2]));
      List<String> endDateList = endDateString.split("-");
      DateTime endDate = DateTime(int.parse(endDateList[0]), int.parse(endDateList[1]), int.parse(endDateList[2]));

      var finalOrMidtermMarkElement = courseElement.querySelector('td:nth-child(3) > span');
      bool hasFinal = false;
      bool hasMidterm = false;
      String finalOrMidtermMark = "0";
      if (finalOrMidtermMarkElement != null) {
        finalOrMidtermMark = finalOrMidtermMarkElement.innerText;
        if (finalOrMidtermMark.contains("F")) {
          hasFinal = true;
          finalOrMidtermMark = finalOrMidtermMark.replaceAll(RegExp('(FINAL MARK: )|%'), "");
        } else {
          hasMidterm = true;
          finalOrMidtermMark = finalOrMidtermMark.replaceAll(RegExp('(MIDTERM MARK: )|%'), "");
        }

      }

      var markElement = courseElement.querySelector('td:nth-child(3) > a');
      String markString = "-1";
      bool hasMark = false;
      String url = "https://ta.yrdsb.ca/live/students/";
      if (markElement != null) {
        hasMark = true;
        markString = markElement.innerHtml!.trim().replaceAll(RegExp('(current mark = )|%'), "").trim();
        // markString = "Level 4-";
        url += markElement.attributes['href']!;
      }

      
      // debug("course code: $code");
      // debug("course name: $name");
      // debug("period: $period");
      // debug("room: $room");
      // debug("start date: $startDateString");
      // debug("end date: $endDateString");
      // if (hasFinal) {
      //   debug("final mark: $finalOrMidtermMark");
      // } else if (hasMidterm) {
      //   debug("midterm mark: $finalOrMidtermMark");
      // }
      // if (hasMark) {
      //   debug("current mark: $mark");
      //   debug("course url: $url");
      // } else {
      //   debug("mark not available");
      // }

      // debug("-----");
      
      final Course course = Course(code, name, period, room, startDate, endDate, hasFinal, hasMidterm, int.parse(finalOrMidtermMark), hasMark, markString, Uri.parse(url));
      courses.add(course);
    }
  return courses;
  }
}
