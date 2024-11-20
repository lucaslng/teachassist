import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teachassist/pages/overviewpage.dart';
import 'package:teachassist/pages/settings/settingspage.dart';
import 'package:teachassist/utils/coursedata/course.dart';
import 'package:teachassist/utils/debug.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  final List<Course> data;
  const HomePage({super.key, required this.data});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget page(List<Course> data) {
      switch (_selectedIndex) {
        case 0:
          return OverviewPage(data);
        case 1:
          return SettingsPage();
        default:
          throw UnimplementedError("No widget for selected index: $_selectedIndex");
      }
    }
    
    return Scaffold(
      body: page(widget.data),
      bottomNavigationBar: NavigationBar(
        elevation: 3,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
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
  }
}
