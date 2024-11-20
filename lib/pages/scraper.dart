import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teachassist/pages/loadingpage.dart';
import 'package:teachassist/route/router.gr.dart';
import 'package:teachassist/utils/coursedata/course.dart';
import 'package:teachassist/utils/debug.dart';
import 'package:teachassist/utils/scraper.dart';

@RoutePage()
class ScraperSplash extends StatefulWidget {
  final String id;
  final String password;
  const ScraperSplash(this.id, this.password);
  @override
  State<ScraperSplash> createState() => _ScraperSplashState();
}

class _ScraperSplashState extends State<ScraperSplash> {
  Scraper scraper = Scraper("", "");
  Future<List<Course>>? data;

  Future<void> scrape() async {
    data = scraper.fetchData();
  }

  @override
  void initState() {
    super.initState();
    var scraper = Scraper(widget.id, widget.password);
    data = scraper.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        var router = AutoRouter.of(context);
        if (snapshot.hasData) {
          router.push(HomeRoute(data: snapshot.data!));
        } else if (snapshot.hasError) {
          router.push(ErrorRoute(snapshot: snapshot));
        }
        return const LoadingPage();
      }
    );
  }
}