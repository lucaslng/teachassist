import 'dart:convert';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:teachassist/utils/coursedata/assignment.dart';
import 'package:teachassist/utils/coursedata/course.dart';
import 'package:teachassist/utils/coursedata/mark.dart';
import 'package:teachassist/utils/debug.dart';
import 'package:universal_html/html.dart';
import 'package:universal_html/parsing.dart';

class Scraper {
  final HttpClient _client = HttpClient();
  String id = "";
  String password = "";
  Scraper(this.id, this.password);
  
  final CookieJar _cookieJar = CookieJar();
  
  Future<HttpClientResponse> _makeRequest(Uri uri) async {

    debug("attempting to connect to $uri");
    
    var request = await _client.getUrl(uri);
    request.cookies.addAll(await _cookieJar.loadForRequest(uri));
    request.followRedirects = false;
    HttpClientResponse response = await request.close();
    _cookieJar.saveFromResponse(uri, response.cookies);

    // debug("\n");
    debug("succesfully connected to $uri");
    // debug(response.statusCode);
    // debug(response.headers);
    // debug("\n");
    
    if (response.isRedirect) {
      Uri location = Uri.parse(response.headers.value(HttpHeaders.locationHeader)!);

      if (location == Uri.parse("https://ta.yrdsb.ca/live/index.php?error_message=3")) {
        
        return Future.error("Invalid login");
      } else {
        debug("\nredirecting to $location \n");
        return _makeRequest(location);
      }
      
    } else {
      debug("succesfully connected to $uri");
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
      final String responseBody = await response.transform(utf8.decoder).join();
      // debug(responseBody);
      List<Course> courses = _parseHomeData(responseBody);
      debug("${courses.length} courses found");
      for (var course in courses) {
        try {
          if (course.url != Uri.parse("https://ta.yrdsb.ca/live/students/") && !course.url.toString().contains("viewReportOE")) {
            HttpClientResponse courseResponse = await _makeRequest(course.url);
            debug("requesting ${course.name} ${course.url}");
              if (courseResponse.statusCode == 200) {
                debug("requesting ${course.name} ${course.url} success");
                final Future<String> courseResponseBody = courseResponse.transform(utf8.decoder).join();
                final List<Assignment> assignments = _parseCourseData(await courseResponseBody);
                course.assignments = assignments;
              }
          }
          } catch (e) {
            course.assignments = [];
        }
      }
      return courses;
    } else {
      return Future.error(Exception("error: ${response.statusCode}"));
    }
  }


  
  List<Assignment> _parseCourseData(String data) {
    final List<Assignment> assignments = [];

    final HtmlDocument doc = parseHtmlDocument(data);

    final List<Element> assignmentsElement = doc.querySelector('body > div > div:nth-child(3) > div > div > table:nth-child(1) > tbody')!.children.toList(); // 
	  final int categories = assignmentsElement[0].children.length;
    assignmentsElement.removeRange(0, 1);
    for (var i = 0; i < assignmentsElement.length; i += 2) {
		  List<Element> assignmentElement = assignmentsElement[i].children;
      final String name = assignmentElement[0].innerText.trim();
      // debug(name);
      final String feedback = assignmentsElement[i+1].children[0].innerText.replaceAll("\n\n", "\n").trim();

      final Assignment assignment = Assignment(name: name, feedback: feedback);

      

      for (int j = 1; j < categories; j++) {
        final Element? element = assignmentElement[j].querySelector('table > tbody > tr > td');
        final double mark = double.parse(element?.innerText.split("\n")[0].trim().split(RegExp(' (/|=) '))[0] ?? "-1");
        final int total = int.parse(element?.innerText.split("\n")[0].trim().split(RegExp(' (/|=) '))[1] ?? "-1");
        final int percent = int.parse(element?.innerText.split("\n")[0].trim().split(RegExp(' (/|=) '))[2].replaceFirst("%", "") ?? "-1");
        // debug(percent);
        final double weight = double.parse(element?.innerText.split("\n")[1].trim().replaceAll("weight=", "").replaceAll("no weight", "-1") ?? "-1");
        final Mark markClass = Mark(mark: mark, total: total, percent: percent, weight: weight);
        // debug(markClass.toString());
        assignment.marks.add(markClass);
      }
      assignments.add(assignment);
    }

    return assignments;
  }

  List<Course> _parseHomeData(String data) {
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