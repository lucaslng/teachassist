import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachassist/course.dart';
import 'package:teachassist/errorpage.dart';
import 'package:teachassist/loadingscreen.dart';
import 'package:teachassist/main.dart';
import 'package:teachassist/overviewpage.dart';
import 'package:teachassist/scraper.dart';
import 'package:teachassist/settingspage.dart';
import 'package:teachassist/tools/debug.dart';

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
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);

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
          if (snapshot.hasData) {
            
            appState.data = snapshot.data;
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
            children = const LoadingScreen();
          }
          return Scaffold(
            body: children,
          );
        }
      ),
    );
  }
}
