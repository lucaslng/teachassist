import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachassist/main.dart';
import 'package:teachassist/pages/errorpage.dart';
import 'package:teachassist/pages/loadingpage.dart';
import 'package:teachassist/pages/overviewpage.dart';
import 'package:teachassist/pages/settings/settingspage.dart';
import 'package:teachassist/utils/coursedata/course.dart';
import 'package:teachassist/utils/debug.dart';
import 'package:teachassist/utils/scraper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.id, required this.password});

  final String id;
  final String password;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  late Future<List<Course>> data;
  
  @override
  void initState() {
    super.initState();

    Scraper scraper = Scraper(widget.id, widget.password);
    data = scraper.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = OverviewPage();
        break;
      case 1:
        page = SettingsPage();
        break;
      default:
        throw UnimplementedError("No widget for selected index: $_selectedIndex");
    }
    
    return SafeArea(
      child: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          Widget children;
          debug("data changed: $data");
          if (snapshot.hasData) {
            appState.data = snapshot.data;
            debug(snapshot.data!.length.toString());
            children = Scaffold(
              body: page,
              bottomNavigationBar: NavigationBar(
                elevation: 3,
                // backgroundColor: ,
                destinations: const [
                  NavigationDestination(
                    label: "Home",
                    icon: Icon(Icons.home),
                  ),
                  NavigationDestination(
                    label: "Settings",
                    icon: Icon(Icons.settings),
                  ),
                ],
                selectedIndex: _selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    _selectedIndex =  value;
                  });
                },
              )
            );
          } else if (snapshot.hasError) {
            children = ErrorPage(snapshot: snapshot);
          } else {
            debug("loading page");
            children = const LoadingPage();
          }
          return Scaffold(
            body: children,
          );
        }
      ),
    );
  }
}
